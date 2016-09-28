class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new; end

  def create
    # Here is where we would save to the database
    redirect_to tasks_path
  end
end
