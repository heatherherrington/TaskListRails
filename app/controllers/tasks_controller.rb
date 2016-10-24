class TasksController < ApplicationController
  skip_before_action :require_login, only: [:welcome, :create]

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

  def show
    requested_task = Task.find(params[:id])

    if requested_task.user_id == current_user.id
      @task = current_user.tasks.find(params[:id])
    else
      redirect_to :unauth_req
    end
  end

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

  def edit  # Will give the form, like new
    requested_task = Task.find(params[:id])

    if requested_task.user_id == current_user.id
      @task = current_user.tasks.find(params[:id])
    else
      redirect_to :unauth_req and return
    end
  end

  def update # Actually do the update, like create
    requested_task = Task.find(params[:id])

    if requested_task.user_id == current_user.id
      @task = current_user.tasks.find(params[:id])
    else
      redirect_to :unauth_req and return
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :is_completed, :completed_at)
  end
end
