class Legislator < ApplicationRecord
  belongs_to :bill, optional: true
  belongs_to :vote_result, optional: true
  belongs_to :vote, optional: true

  def self.to_csv
    attributes = %w{id name num_supported_bills num_opposed_bills}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |legislator|
        csv << legislator.attributes.values_at(*attributes)
      end
    end
  end
end
