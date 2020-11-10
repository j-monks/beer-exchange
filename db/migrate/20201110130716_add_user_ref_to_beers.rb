class AddUserRefToBeers < ActiveRecord::Migration[6.0]
  def change
    add_reference :beers, :user, null: false, foreign_key: true
  end
end
