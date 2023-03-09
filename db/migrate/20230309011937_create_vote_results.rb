class CreateVoteResults < ActiveRecord::Migration[7.0]
  def change
    create_table :vote_results do |t|
      t.integer :vote_result_id
      t.integer :legislator_id
      t.integer :vote_id
      t.integer :vote_type

      t.timestamps
    end
  end
end
