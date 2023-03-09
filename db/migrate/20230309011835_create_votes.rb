class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :vote_id
      t.integer :bill_id

      t.timestamps
    end
  end
end
