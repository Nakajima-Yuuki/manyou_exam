class AddExpirationDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expiration_date, :datetime
  end
end
