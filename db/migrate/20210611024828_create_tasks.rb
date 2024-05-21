class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_name ,null: false
      t.string :task_description
      t.string :task_priority
      t.references :users
      t.timestamps
    end
  end
end
