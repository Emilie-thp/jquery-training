class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
      if @task.save
        respond_to do |format|
          format.html { redirect_to root_path, flash[:notice] = "Task created"}
          format.js {}
        end
      else
        redirect_to root_path
        flash[:notice] = "Please try again"
      end
  end




  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

def update
    puts "*"*50
    puts params
    puts "*"*50
    if params[:checkbox] = 1
      @task = Task.find(params[:id])
      @task.status = params[:status]
      if @task.save
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js { }
          flash[:notice] = "Task edited"
        end
      else
       @task = Task.find(params[:id])
       @task.update(params)
       redirect_to root_path
       flash[:notice] = "Task edited"
     end
   end
 end


  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end

  end


  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
