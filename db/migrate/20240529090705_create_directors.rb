class CreateDirectors < ActiveRecord::Migration[7.1]
  def change
    create_table :directors do |t|
      t.string :name
      t.string :designation
      t.string :contact_information
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
