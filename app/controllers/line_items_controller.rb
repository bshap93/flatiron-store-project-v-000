class LineItemsController < ApplicationController
  def create
    current_user.current_cart || current_user.create_current_cart
    @cart = current_user.current_cart
    line_item = @cart.line_items.find_or_create_by(item_id: params[:item_id])
    line_item.quantity += 1
    line_item.save
    redirect_to cart_path(@cart)
  end
end
