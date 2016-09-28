class TasksController < ApplicationController
  def index
    @id = params[:id]
    @tasks = [
      {
        task: "Grocery shopping",
        description: "fruit, bread, turkey",
        completion_status: "incomplete",
        completion_date: "Sept 27, 2016"
      },
      {
        task: "Laundry",
        description: "darks",
        completion_status: "in-progress",
        completion_date: "Sept 30, 2016"
      }
    ]
  end

  def show
    @id = params[:id]
    @tasks = [
      {
        task: "Grocery shopping",
        description: "fruit, bread, turkey",
        completion_status: "incomplete",
        completion_date: "Sept 27, 2016"
      },
      {
        task: "Laundry",
        description: "darks",
        completion_status: "in-progress",
        completion_date: "Sept 30, 2016"
      }
    ]
  end
end
