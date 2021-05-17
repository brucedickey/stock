class User < ApplicationRecord
  has_many :user_stocks
  has_many :company_stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name 
    name = "#{first_name} #{last_name}"
    name.strip! || name
  end         


  # USER STOCKS       
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


  # USER FRIENDS
  def self.friend_lookup(name) 
    friends = User.where("LOWER(first_name)=?", name.downcase).or(
              User.where("LOWER(last_name)=?", name.downcase)
              )
    return (friends)? friends : nil
  end

  def friend_already_displayed?(user, friend) 
    Friendship.find_by(user_id: user.id, friend_id: friend.id)
  end 

  def under_friend_limit? 
    Friendship.count < 10
  end
end
