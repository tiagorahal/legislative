class Vote < ApplicationRecord
  has_many :bills, dependent: :destroy
  has_many :legislators, dependent: :destroy
end
