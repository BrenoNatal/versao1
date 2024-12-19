class CreateDeposits < ActiveRecord::Migration[8.0]
  def change
    create_table :deposits do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
