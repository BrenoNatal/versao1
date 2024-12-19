class AddAccountIdToWithdrawals < ActiveRecord::Migration[8.0]
  def change
    add_column :withdrawals, :account_id, :integer
    add_index :withdrawals, :account_id
  end
end
