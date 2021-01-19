class RemoveForeignKeyForUserStocksToStocks < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :user_stocks, :stocks
    remove_column :user_stocks, :stock_id
  end
end
