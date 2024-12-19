class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :target_name
      t.string :source_name

      t.timestamps
    end
  end
end
