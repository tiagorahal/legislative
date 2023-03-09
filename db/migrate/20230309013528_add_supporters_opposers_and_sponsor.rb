class AddSupportersOpposersAndSponsor < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :supporter_count, :integer
    add_column :bills, :opposer_count, :integer
    add_column :bills, :primary_sponsor_name, :string
  end
end
