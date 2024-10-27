class TasksController < ApplicationController
  before_action :set_category, only: [:index, :new, :create]
  before_action :set_task, only: [:complete, :edit, :update, :destroy]

  def index
    @tasks = @category.tasks.where(status: 'incomplete')
  end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)
    @task.status = 'incomplete'
    if @task.save
      redirect_to category_tasks_path(@category), notice: 'Task created successfully.'
    else
      render :new
    end
  end

  def complete
    @task.update(status: 'complete')
    redirect_to category_tasks_path(@task.category), notice: 'Task marked as complete.'
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_tasks_path(@task.category), notice: 'Task updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(@task.category), notice: 'Task deleted successfully.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title)
  end
end
