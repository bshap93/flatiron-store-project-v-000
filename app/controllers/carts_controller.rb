class CartsController < ApplicationController
  before_action :require_cart_is_users
  skip_before_action :require_cart_is_users, only: [:create]

  def show
    @cart = Cart.find(params[:id])
  end

  def create
    current_user.create_current_cart
    @cart = Cart.last
    redirect_to cart_path(@cart)
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.checkout
    current_user.current_cart = nil
    current_user.save
    old_cart = Cart.find(params[:id])
    redirect_to cart_path(old_cart)
  end

  private
  def require_cart_is_users
    unless current_user.carts.include?(Cart.find(params[:id]))
      redirect_to store_path
    end
  end

end
