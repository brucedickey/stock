class UserStocksController < ApplicationController

  def create 
    # Add stock to list of tracked stocks

    ticker = params[:ticker].upcase
    stock  = CompanyStock.check_db(ticker)

    if stock.blank? || stock.last_price.nil?
      # We are not tracking this stock, or the price was not fetched in early development.
      # Call 3rd party API to look up stock info.
      stock = CompanyStock.stock_lookup(ticker)
      stock.save
    end  

    @user_stock    = UserStock.create(user: current_user, company_stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio."

    redirect_to my_portfolio_path
  end 

  def destroy 
    # Remove stock from list of tracked stocks
    stock      = CompanyStock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, company_stock_id: stock.id).first

    user_stock.destroy

    flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio."

    redirect_to my_portfolio_path
  end
end
