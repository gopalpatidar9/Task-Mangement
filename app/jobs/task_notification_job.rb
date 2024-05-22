class TaskNotificationJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Running TaskNotificationJob"
    
    # Find overdue tasks that have not had an email sent
    overdue_tasks = Task.where("task_day < ?", Date.today)
                        .where(task_status: false, email_sent_for_due_date_missed: false)
    
    overdue_tasks.each do |task|
      UserMailer.task_due_date_notification_email(task).deliver_now
      Rails.logger.info "Sent due date notification email to #{task.user.email} for task #{task.task_name}"
      task.update(email_sent_for_due_date_missed: true)
    end
    
    Rails.logger.info "Running check for tasks due tomorrow"
    tomorrow = Date.tomorrow
    tasks_due_tomorrow = Task.where(task_day: tomorrow)
                             .where(email_sent_for_due_date_tomorrow: false)

    tasks_due_tomorrow.each do |task|
      user = task.user
      UserMailer.task_due_tomorrow_notification_email(user, task).deliver_now
      Rails.logger.info "Sent notification email to #{user.email} for task #{task.task_name} due tomorrow"
      task.update(email_sent_for_due_date_tomorrow: true)
    end
  end

end

