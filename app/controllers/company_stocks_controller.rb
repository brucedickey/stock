class CompanyStocksController < ApplicationController

  def search 
    if params[:stock].present?
      @stock = CompanyStock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end 
      else 
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid stock symbol"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a stock symbol"
        format.js { render partial: 'users/result' }
      end
    end 
  end

end
