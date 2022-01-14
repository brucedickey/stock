class UsersController < ApplicationController
  def my_friends
    @tracked_friends = current_user.friends
  end

  def my_portfolio
    @user           = current_user
    @tracked_stocks = get_latest_stock_prices(current_user.company_stocks)
  end

  def search 
    if params[:friend].present?
      @friends = User.friend_lookup(current_user, params[:friend])

      if !@friends.blank?
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end 
      else 
        respond_to do |format|
          flash.now[:alert] = "The friend was not found"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend's name"
        format.js { render partial: 'users/friend_result' }
      end
    end 
  end

  def show 
    @user           = User.find(params[:id]) 
    stocks          = @user.user_stocks 
    @tracked_stocks = stocks.map { |stock| CompanyStock.find(stock.company_stock_id) }
    @tracked_stocks = get_latest_stock_prices(@tracked_stocks)
  end  

  private

  def get_latest_stock_prices(tracked_stocks) 
    tracked_stocks.each { |stock| stock.last_price = CompanyStock.price_lookup(stock.ticker) }
  end
end
