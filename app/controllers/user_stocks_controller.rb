class UserStocksController < ApplicationController

  def create 
    stock = CompanyStock.check_db(params[:ticker])
    if stock.blank?
      stock = CompanyStock.new_lookup(params[:ticker])
      stock.save
    end  

    @user_stock    = UserStock.create(user: current_user, company_stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio."

    redirect_to my_portfolio_path
  end 

  def destroy 
    stock      = CompanyStock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, company_stock_id: stock.id).first
    user_stock.destroy

    flash[:notice] = "#{stock.ticker} was successfully removed from the portfolio."

    redirect_to my_portfolio_path
  end
end
