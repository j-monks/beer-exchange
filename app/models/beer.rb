class Beer < ApplicationRecord
  belongs_to :user
  belongs_to :instance
end
