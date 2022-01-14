class User < ApplicationRecord
  has_many :user_stocks
  has_many :company_stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # USER STOCKS       
  def can_track_another_stock?(current_user, ticker_symbol) 
    under_stock_limit?(current_user) && !stock_already_tracked?(current_user, ticker_symbol)
  end 

  def stock_already_tracked?(current_user, ticker_symbol) 
    company_stock = CompanyStock.check_db(ticker_symbol)

    return false unless company_stock

    #company_stocks.where(id: stock.id).exists?
    stock = UserStock.where(user_id: current_user.id, company_stock_id: company_stock.id).first
    
    return false if stock.blank?
    true
  end 

  def under_stock_limit?(current_user) 
    #company_stocks.count < 10
    UserStock.where(user_id: current_user.id).count < 10
  end


  # USER FRIENDS
  def self.friend_lookup(current_user, search_term)
    search_term.downcase.strip 

    friends = where("LOWER(first_name) like ?", "%#{search_term}%")
      .or(    where("LOWER(last_name) like ?", "%#{search_term}%") )
      .or(    where("LOWER(email) like ?", "%#{search_term}%") )
      .uniq

    friends = friends.reject { |x| x.id == current_user.id }

    return (friends)? friends : nil
  end

  def friend_already_displayed?(friend) 
    self.friends.where(id: friend.id).exists?
  end 

  def full_name 
    return "#{first_name} #{last_name}".strip if first_name || last_name
    "Anonymous"
  end 

  def under_friend_limit? 
    self.friends.count < 10
  end
end
