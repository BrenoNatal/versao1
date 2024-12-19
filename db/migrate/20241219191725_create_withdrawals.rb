class CreateWithdrawals < ActiveRecord::Migration[8.0]
  def change
    create_table :withdrawals do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
