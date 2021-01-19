class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.company_stocks
  end
end
