class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.json :contact_data
      t.json :addresses
      t.json :family
      t.timestamps
    end
  end
end
