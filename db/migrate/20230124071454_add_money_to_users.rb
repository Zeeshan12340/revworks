class AddMoneyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :money, :decimal, default: 1
  end
end
