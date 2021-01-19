class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :company_stock
end
