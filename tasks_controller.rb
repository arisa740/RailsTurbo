class TasksController < ApplicationController
  before_action :set_task, only: [:complete, :destroy]

  def index
    @tasks = Task.where(status: 'incomplete')
    @new_task = Task.new
  end

  def create
    @new_task = Task.new(task_params)
    @new_task.status = 'incomplete'
    if @new_task.save
      redirect_to tasks_path
    else
      render :index
    end
  end

  def complete
    @task.update(status: 'complete')
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
