class AddResubmittedToKybApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :kyb_applications, :resubmitted, :boolean, default: false
  end
end
