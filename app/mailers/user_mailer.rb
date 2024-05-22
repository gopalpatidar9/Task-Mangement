class UserMailer < ApplicationMailer
    default from: 'gopalpatidara9@gmail.com'

    def task_due_tomorrow_notification_email(user, task)
        @user = user
        @task = task
        mail(to: @user.email, subject: "Your Task is Due Tomorrow")
    end

    def test_email(user)
        @user = user
        mail(to: @user.email, subject: 'Test Email')
    end

    def task_due_date_notification_email(task)
        @task = task
        @user = task.user # Assuming Task belongs to User
        mail(to: @user.email, subject: 'Your Task is Overdue')
    end
end

