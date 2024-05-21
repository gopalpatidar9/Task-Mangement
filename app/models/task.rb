class Task < ApplicationRecord
	belongs_to :user

	attribute :task_color, :string, default: 'bg-primary text-white'
	attribute :task_status, :boolean, default: false

	def self.check_missed_tasks
		Rails.logger.info "Running check_missed_tasks"
		missed_tasks = where('task_day < ? AND task_status = ?', Date.today, false)
		missed_tasks.each do |task|
		  UserMailer.missed_task_alert(task.user, task).deliver_now
		  Rails.logger.info "Sent missed task alert to #{task.user.email} for task #{task.task_name}"
		end
	  end
end


