class AddNumberOfSupportedAndOpposedBills < ActiveRecord::Migration[7.0]
  def change
    add_column :legislators, :num_supported_bills, :integer
    add_column :legislators, :num_opposed_bills, :integer
  end
end
