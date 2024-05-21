class TaskNotificationJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Running TaskNotificationJob"
    overdue_tasks = Task.where("task_day < ?", Date.today).where(task_status: false)
    overdue_tasks.each do |task|
      UserMailer.task_due_date_notification_email(task).deliver_now
      Rails.logger.info "Sent due date notification email to #{task.user.email} for task #{task.task_name}"
    end
  end

end

