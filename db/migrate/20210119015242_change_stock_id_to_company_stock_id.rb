class ChangeStockIdToCompanyStockId < ActiveRecord::Migration[6.0]
  def change
    remove_index :user_stocks, :stock_id
    remove_column :user_stocks, :stock_id
    add_index :user_stocks, :company_stock_id
  end
end
