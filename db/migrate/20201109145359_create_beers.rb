class CreateBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :address
      t.string :address_line2
      t.text :preferences

      t.timestamps
    end
  end
end
