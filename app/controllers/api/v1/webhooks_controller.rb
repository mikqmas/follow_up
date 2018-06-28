class Api::V1::WebhooksController < ApplicationController
  include Util
  def notify
    # get verification
    verification = webhook_params[:verificationCode]
    puts verification
    # conditions run methods
    if webhook_params["appId"] == ENV["CLIENT_ID"]
      merchant_events = webhook_params["merchants"]
      merchant_keys = webhook_params["merchants"].keys
      merchant_keys.each do |merchant_id|
        merchant_events[merchant_id].each do |event|
          if event["objectId"][0] == "P" && event["type"] == "CREATE"
            begin
              payment = get_payment(merchant_id, event["objectId"].slice(2,-1))
              order = get_order_from_payment(payment)
              email = create_customer_email(order, payment, merchant_id)
              send_email(email)
            rescue => ex
              logger.error ex.message
            end
          end
        end
      end
    else
      # format.html { render :new }
      format.json { render json: {}, status: :unprocessable_entity }
    end
  end

  def get_payment(merchant_id, payment_id)
    url = `https://sandbox.dev.clover.com/v3/merchants/#{merchant_id}/payments/#{payment_id}`
    response = get(url)
    if response.code == "200"
      return JSON.parse(response.body)
    else
      throw Error "failed to get payment"
    end
  end

  def get_order_from_payment(payment)
    url = `https://sandbox.dev.clover.com/v3/merchants/#{merchant_id}/orders/#{payment.order.id}`
    response = get(url)
    if response.code == "200"
      return JSON.parse(response.body)
    else
      throw Error "failed to get order"
    end
  end

  def create_customer_email(order, payment, merchant_id)
    customer = payment.customer
    local_customer = Customer.find_by(customer_uuid: customer.id)
    unless local_customer
      local_customer = Customer.create(name: customer.name,
        email: customer.email,
        allow_marketing: customer.allow_marketing,
        merchant_id: merchant_id)
    end
    email = local_customer.emails.create(order_id: order.id)
  end

  def send_email(email)
    SendEmailJob.set(wait: 20.seconds).perform_later(email)
    # format.html { redirect_to @user, notice: 'User was successfully create.'}
    format.json { render :show, status: :created, location: email }
  end

  private
  def webhook_params
    params.permit(:verificationCode, :appId, :merchants)
  end
end
