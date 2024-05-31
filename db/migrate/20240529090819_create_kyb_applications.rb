class CreateKybApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :kyb_applications do |t|
      t.string :status, default: 'pending'
      t.text :rejection_reason
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
