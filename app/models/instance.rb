class Instance < ApplicationRecord
  belongs_to :user
  has_many :beers
  has_many :users, through: :beers
end
