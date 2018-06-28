require "net/https"
require "uri"

module Api::V1
  class CloversController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :require_logged_in, only: [:test]

    def login
      user = User.last
      login!(user)
      ses = session[:session_token]
      render json: {"ses": ses}
    end

    def test
      ses = session[:session_token]
      render json: {"ses": ses}
      # render json: {"test": "success", "session": session[:session_token]}
    end

    def auth
      # grab params
      # check see if user exists
      # post to clover
      # grab token
      # create user
      # send json back to FE
      debugger
      merchant_id = params[:merchant_id]
      app_id = params[:client_id]
      code = params[:code]
      app_secret = ENV["APP_SECRET"]

      user = User.find_by(merchant_id: merchant_id)

      auth_url = "https://sandbox.dev.clover.com/oauth/token?client_id=#{app_id}&client_secret=987fda60-b5ed-18ee-99c1-18667de95d8b&code=#{code}"

      uri = URI.parse(auth_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)

      if response.code == '200'
        if user
          redirect_to "/dash"
        else
          token = JSON.parse(response.body)['access_token']
          begin
            merchant_json = get_merchant(merchant_id, token)
            owner = merchant_json['owner']
            name = owner['name']
            email = owner['email']
            user = User.new(merchant_id: merchant_id, username: name, email: email, token: token)
            if user.save
              redirect_to "/dash"
            else
              redirect_to "/signup?owner=#{owner}&name=#{name}&email=#{email}"
            end
          rescue => ex
            logger.error ex.message
            redirect_to "/404"
          end
        end
      else
        redirect_to "/404"
      end
    end

    def get_merchant(merchant_id, token)
      url = "https://sandbox.dev.clover.com/v3/merchants/#{merchant_id}/?expand=owner"
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

    def create_user(token)
      # User.new(username: )
    end

    def webhook
      # get verification
      verif = clover_params[:verificationCode]
      puts verif
      # conditions run methods
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

    private
    def clover_params
      params.permit(:verificationCode)
    end
  end
end
