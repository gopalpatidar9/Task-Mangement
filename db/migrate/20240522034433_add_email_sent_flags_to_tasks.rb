class AddEmailSentFlagsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :email_sent_for_due_date_missed, :boolean
    add_column :tasks, :email_sent_for_due_date_tomorrow, :boolean
  end
end
