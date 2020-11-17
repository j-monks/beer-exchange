class CreateInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :instances do |t|
      t.references :user
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end
