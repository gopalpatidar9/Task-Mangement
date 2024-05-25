class HomeController < ApplicationController
  def index
    @tasks = current_user.tasks.all
  end

  def profile
    @tasks = current_user.tasks.all
    @high_priorty_tasks = current_user.tasks.where(task_priority: 'High')
  end
end
