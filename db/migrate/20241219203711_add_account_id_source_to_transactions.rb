class AddAccountIdSourceToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :account_id_source, :integer
    add_index :transactions, :account_id_source
  end
end
