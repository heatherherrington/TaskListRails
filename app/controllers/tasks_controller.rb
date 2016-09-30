class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to root_path
  end

  def edit  # Will give the form, like new
    @task = Task.find(params[:id])
  end

  def update # Actually do the update, like create
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :is_completed, :completed_at)
  end
end
