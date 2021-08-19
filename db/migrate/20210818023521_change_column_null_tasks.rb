class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :name, false
    change_column_null :tasks, :description, false
  end
end
