class AddFeeToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :fee, :decimal
  end
end
