class AddAccountIdTargetToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :account_id_target, :integer
    add_index :transactions, :account_id_target
  end
end
