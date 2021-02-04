class User < ApplicationRecord
  has_many :user_stocks
  has_many :company_stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_track_another_stock?(ticker_symbol) 
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end 

  def stock_already_tracked?(ticker_symbol) 
    stock = CompanyStock.check_db(ticker_symbol)
    return false unless stock

    company_stocks.where(id: stock.id).exists?
  end 

  def under_stock_limit? 
    company_stocks.count < 10
  end
end
