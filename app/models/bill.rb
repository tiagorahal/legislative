class Bill < ApplicationRecord
  belongs_to :legislator, optional: true
  belongs_to :vote_result, optional: true
  belongs_to :vote, optional: true

  def self.to_csv
    attributes = %w{id title primary_sponsor_name supporter_count opposer_count}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |bill|
        csv << bill.attributes.values_at(*attributes)
      end
    end
  end
end
