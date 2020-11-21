class Instance < ApplicationRecord
  belongs_to :user
  has_many :beers
end

# removed because it cause buggy behaviour: has_many :users, through: :beers
