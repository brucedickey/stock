class CompanyStocksController < ApplicationController

  def search 
    if params[:stock].present?
      ticker = params[:stock].strip
      @stock = CompanyStock.stock_lookup(ticker)
      
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/stock_result' }
        end 
      else 
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid stock symbol"
          format.js { render partial: 'users/stock_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a stock symbol"
        format.js { render partial: 'users/stock_result' }
      end
    end 
  end
end
