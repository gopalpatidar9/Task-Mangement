class SetDefaultEmailSentFlagsForTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :email_sent_for_due_date_missed, from: nil, to: false
    change_column_default :tasks, :email_sent_for_due_date_tomorrow, from: nil, to: false

    reversible do |dir|
      dir.up do
        Task.where(email_sent_for_due_date_missed: nil).update_all(email_sent_for_due_date_missed: false)
        Task.where(email_sent_for_due_date_tomorrow: nil).update_all(email_sent_for_due_date_tomorrow: false)
      end
    end
  end
end
