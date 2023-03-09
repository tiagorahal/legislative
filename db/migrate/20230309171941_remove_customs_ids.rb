class RemoveCustomsIds < ActiveRecord::Migration[7.0]
  def change
    remove_column :bills, :bill_id
    remove_column :legislators, :legislator_id
    remove_column :vote_results, :vote_result_id
    remove_column :votes, :vote_id
  end
end
