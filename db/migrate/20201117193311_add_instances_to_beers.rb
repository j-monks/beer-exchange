class AddInstancesToBeers < ActiveRecord::Migration[6.0]
  def change
    add_reference :beers, :instance, null: false, foreign_key: true
  end
end
