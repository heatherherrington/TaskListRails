class TasksController < ApplicationController
  skip_before_action :require_login, only: [:welcome, :create]
  before_action :edit_update_show, only: [:edit, :update, :show]

  def welcome
    if !session[:user_id].blank?
      redirect_to :tasks and return
    else
      render :welcome
    end
  end

  def index
    @tasks = current_user.tasks
    # @complete_tasks = @tasks.complete_tasks
    # @incomplete_tasks = @tasks.incomplete_tasks
  end

  def show; end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  def edit; end

  def update; end

  private

  def task_params
    params.require(:task).permit(:name, :description, :is_completed, :completed_at)
  end

  def edit_update_show
    requested_task = Task.find(params[:id])

    if requested_task.user_id == current_user.id
      @task = current_user.tasks.find(params[:id])
    else
      redirect_to :unauth_req and return
    end
  end
end
