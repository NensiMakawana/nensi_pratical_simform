class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token  


  def create
    respond_to do |format|
      @user_exist =  User.find_by(email: params[:email])
      if @user_exist.present?
        token = SecureRandom.hex
        @user_exist.update(auth_token: token)
        if sign_in @user_exist
          msg = { auth_token: @user_exist.auth_token, id: @user_exist.id }
          format.json  { render :json => msg }
        else
          msg = { messages: "You are not authorized to login.", status: 0 }
          format.json  { render :json => msg }
        end
      else
        msg = { messages: "You are not authorized to login.", status: 0 }
        format.json  { render :json => msg }
      end
    end
  end
end