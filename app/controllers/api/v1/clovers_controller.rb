class Api::V1::CloversController < ApplicationController
  include Util

  def auth
    merchant_id = params[:merchant_id]
    app_id = params[:client_id]
    code = params[:code]
    app_secret = ENV["APP_SECRET"]

    # make token https request
    auth_url = "https://sandbox.dev.clover.com/oauth/token?client_id=#{app_id}&client_secret=987fda60-b5ed-18ee-99c1-18667de95d8b&code=#{code}"
    response = get(auth_url)

    if response.code == '200'
      # grab token
      token = JSON.parse(response.body)['access_token']
      # login
      login(token, merchant_id)
    else
      redirect_to "/404"
    end
  end

  def login(token, merchant_uuid)
    # check if user exists
    user = User.find_by(merchant_uuid: merchant_uuid)
    if user
      session = user.reset_session_token!
      redirect_to "http://localhost:3000/login?session=#{session}"
      # render json: {token: token}
    else
      # create new user
      begin
        user = create_user(token, merchant_uuid)
        if user.save
          session = user.reset_session_token!
          redirect_to "http://localhost:3000/login?new=true&session=#{session}"
        else
          redirect_to "/signup?owner=#{owner}&name=#{name}&email=#{email}"
        end
      rescue => ex
        logger.error ex.message
        redirect_to "/404"
      end
    end
  end

  def get_merchant(merchant_uuid, token)
    url = "https://sandbox.dev.clover.com/v3/merchants/#{merchant_uuid}/?expand=owner"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "Bearer " + token
    response = http.request(request)

    if response.code == '200'
      return JSON.parse(response.body)
    else
      return {}
    end
  end

  def create_user(token, merchant_uuid)
    merchant_json = get_merchant(merchant_uuid, token)
    owner = merchant_json['owner']
    name = owner['name']
    email = owner['email']
    User.new(merchant_uuid: merchant_uuid, name: name, email: email, token: token)
  end

  def is_new_order(order)
  end

  def has_customer
  end

  def has_email
  end

  def allow_marketing
  end

  def queue_email
  end


end
