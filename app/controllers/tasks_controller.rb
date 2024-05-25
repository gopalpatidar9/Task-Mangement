class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    date = (Date.today)
    @tasks = current_user.tasks.where(task_day: date)
    tomorrow = Date.today+1
    @tasks_day_after_tomorrow = current_user.tasks.where('task_day > ?' , tomorrow)
  end

  
  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.new
    respond_to do |format|
      format.js { render 'tasks/new' }
    end
  end

  # GET /tasks/1/edit
  def edit
    # respond_to do |format|
    #   format.js { render  "tasks/edit" }  
    # end
  end

  # POST /tasks or /tasks.json
  def create
    # get_day = check_task_day(params[:task_day])
    @task = current_user.tasks.new(task_name: params[:task_name], task_description: params[:task_description], task_priority: params[:task_priority],task_color: params[:task_color], task_day: params[:task_day] )
    if @task.save
      respond_to do |format|
        # format.js { render 'tasks/create' }
        format.html { redirect_to tasks_path }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    # get_day = check_task_day(params[:task][:task_day])
    respond_to do |format|
      if @task.update(task_name: params[:task][:task_name], task_description: params[:task][:task_description], task_priority: params[:task][:task_priority], task_day: params[:task][:task_day], task_color: params[:task_color] )
        # @tasks = current_user.tasks.where(task_day: get_day)
        format.js { render 'tasks/task_update' }
      else
        redirect_to root_path
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    task_day = current_user.tasks.find(params[:id]).task_day
    @tasks = current_user.tasks.where(task_day: task_day)
    @task.destroy
    respond_to do |format|
      format.js { render 'tasks/task_update' }
    end
  end

  # def check_task_day(day)
  #   if day == "Day After Tomorrow"
  #     date = Date.today
  #     return (date+2).to_s
  #   elsif day == "Tomorrow"
  #     date = Date.today
  #     return (date+1).to_s
  #   else
  #     return (Date.today).to_s
  #   end
  # end
  
  def update_task_status
    task = Task.find(params[:task_id])
    task.task_status = params[:task_status].eql?('1')
    task.save
    date = task.task_day
    if date == Date.today
      @tasks = current_user.tasks.where(task_day: date)   
    elsif date == Date.today + 1
      @tasks = current_user.tasks.where(task_day: date)
    elsif date == Date.today - 1
      @tasks = current_user.tasks.where(task_day: date )
    else
      @tasks = current_user.tasks.where('task_day > ?', Date.today + 1)
    end
    respond_to do |format|
      format.js { render partial: 'tasks/show_tasks', locals: { tasks: @tasks } }
    end
  end
      
  def filter_task_day
    get_filter_day = params[:filter_day]
    if get_filter_day == 'after_tomorrow'
      tomorrow = Date.today + 1
      @tasks = current_user.tasks.where('task_day > ?', tomorrow)
    else
      @tasks = current_user.tasks.where(task_day: get_filter_day)
    end

    respond_to do |format|
      format.js { render 'tasks/task_filter_by_day' }
    end
  end
  
  def task_update
    @task = current_user.tasks.find(params[:id])
    task_day = @task.task_day
    respond_to do |format|
      format.js { render 'tasks/edit' }
    end
  end
  
  def show_task_details
    @task = current_user.tasks.find(params[:task_id])
    respond_to do |format|
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:task_name, :task_description, :task_priority, :task_day, :task_color)
    end
end


