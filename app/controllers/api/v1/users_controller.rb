module Api::V1
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          SendEmailJob.set(wait: 20.seconds).perform_later(@user)

          # format.html { redirect_to @user, notice: 'User was successfully create.'}
          format.json { render :show, status: :created, location: @user }
        else
          # format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    def user_params
      params.permit(:username, :merchant_id, :token, :email)
    end
  end
end
