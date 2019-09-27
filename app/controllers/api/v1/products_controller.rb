class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  before_action :verify_auth_token

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.json { render json: {name: @product.name, price: @product.price, description: @product.description }}
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end

  def verify_auth_token
    respond_to do |format|
      auth_token = User.find_by(auth_token: params[:auth_token])
      unless auth_token.present?
        msg = { messages: "Please login to processed further.", status: 0 }
        format.json  { render :json => msg }
      else
        format.json  {  true }
      end
    end
  end
end