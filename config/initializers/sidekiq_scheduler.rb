# config/initializers/sidekiq_scheduler.rb
Sidekiq.configure_server do |config|
    config.on(:startup) do
      Sidekiq.schedule = {
        task_due_date_notification: {
          class: 'TaskDueDateNotificationJob',
          cron: '0 8 * * *', # Run every day at 8:00 AM
          queue: 'default'
        }
      }
      Sidekiq::Scheduler.reload_schedule!
    end
end
  