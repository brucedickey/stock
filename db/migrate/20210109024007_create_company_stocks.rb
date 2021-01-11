class CreateCompanyStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :company_stocks do |t|
      t.string :ticker
      t.string :name
      t.decimal :last_price

      t.timestamps
    end
  end
end
