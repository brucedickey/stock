class AddForeignKeyForUserStocksToCompanyStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :user_stocks, :company_stock_id, :bigint
    add_foreign_key :user_stocks, :company_stocks
  end
end
