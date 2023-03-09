class CreateLegislators < ActiveRecord::Migration[7.0]
  def change
    create_table :legislators do |t|
      t.integer :legislator_id
      t.string :name

      t.timestamps
    end
  end
end
