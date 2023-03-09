class VoteResult < ApplicationRecord
  has_many :bills, dependent: :destroy
  has_many :legislators, dependent: :destroy
  has_many :votes, dependent: :destroy
end
