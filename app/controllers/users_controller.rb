class UsersController < ApplicationController
  def show
    user = current_user

    sign_out user
    redirect_to store_path
  end
end
