class UserMailer < ApplicationMailer
    default from: 'gopalpatidara9@gmail.com'

    def missed_task_alert(user, task)
      @user = user
      @task = task
      mail(to: @user.email, subject: 'Missed Task Alert')
    end

    def test_email(user)
        @user = user
        mail(to: @user.email, subject: 'Test Email')
    end

    def task_due_date_notification_email(task)
        @task = task
        @user = task.user # Assuming Task belongs to User
        mail(to: @user.email, subject: 'Task Due Date Notification')
    end
end

