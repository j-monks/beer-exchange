class AddPhoneAndMailToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :phone, :string
    add_column :beers, :email, :string
  end
end
