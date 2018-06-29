class Api::V1::WebhooksController < ApplicationController
  include Util
  def notify
    # get verification
    verification = webhook_params[:verificationCode]
    puts "verification: #{verification}"
    # conditions run methods
    # if webhook_params["appId"] == ENV["CLIENT_ID"]
    merchant_uuids = webhook_params["merchants"].keys
    merchant_uuids.each do |merchant_uuid|
      puts webhook_params["merchants"][merchant_uuid]
    end
    # puts "I'm heree!!!! merchants" + webhook_params["merchants"]
    if webhook_params["appId"]
      merchant_events = webhook_params["merchants"]
      merchant_keys = webhook_params["merchants"].keys
      merchant_keys.each do |merchant_uuid|
        merchant_events[merchant_uuid].each do |event|
          if event["objectId"][0] == "P" && event["type"] == "CREATE"
            begin
              token = get_token(merchant_uuid)
              payment = get_payment(token, merchant_uuid, event["objectId"].slice(2..-1))
              order = get_order_from_payment(token, merchant_uuid, payment)
              email = create_customer_email(order, payment, merchant_uuid)
              send_email(email)
            rescue => ex
              logger.error ex.message
            end
          end
        end
      end
    else
      # format.html { render :new }
      # format.json { render json: {}, status: :unprocessable_entity }
      render json: {pay: "hello"}
    end
  end

  def get_token(merchant_uuid)
    User.find_by(merchant_uuid: merchant_uuid)&.token
  end

  def get_payment(token, merchant_uuid, payment_id)
    url = "https://sandbox.dev.clover.com/v3/merchants/#{merchant_uuid}/payments/#{payment_id}?access_token=#{token}"
    response = get(url)
    if response.code == "200"
      return JSON.parse(response.body)
    else
      raise "failed to get payment"
    end
  end

  def get_order_from_payment(token, merchant_uuid, payment)
    url = "https://sandbox.dev.clover.com/v3/merchants/#{merchant_uuid}/orders/#{payment["order"]["id"]}?expand=customers&access_token=#{token}"
    response = get(url)
    if response.code == "200"
      return JSON.parse(response.body)
    else
      raise "failed to get order"
    end
  end

  def create_customer_email(order, payment, merchant_uuid)
    # customer = order["customers"][0]
    # TODO:: testing
    customer = {"id"=> "test123", "emailAddresses"=> [{"emailAddress"=> "samkim86@gmail.com"}]}
    local_customer = Customer.find_by(customer_uuid: customer["id"])
    unless local_customer
      user = User.find_by(merchant_uuid: merchant_uuid)
      local_customer = Customer.create(customer_uuid: customer["id"], merchant_uuid: merchant_uuid, user_id: user.id)
    end
    email_address = customer["emailAddresses"][0]["emailAddress"]
    Email.create(email_address: email_address, order_uuid: order["id"], customer: local_customer)
  end

  def send_email(email)
    debugger
    SendEmailJob.set(wait: 1.seconds).perform_later(email)
    # format.html { redirect_to @user, notice: 'User was successfully create.'}
    format.json { render :show, status: :created, location: email }
  end

  private
  def webhook_params
    params.require(:webhook)
  end
end
