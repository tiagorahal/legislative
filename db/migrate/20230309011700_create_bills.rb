class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.integer :bill_id
      t.string :title
      t.integer :primary_sponsor_id

      t.timestamps
    end
  end
end
