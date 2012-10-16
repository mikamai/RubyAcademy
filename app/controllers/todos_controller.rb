class TodosController < ApplicationController
  before_filter :find_list

  def new
    @todo = @list.todos.build
  end

  def create
    @todo = @list.todos.build(params[:todo])
    if @todo.save
      redirect_to @list, :notice => 'Todo successfully added.'
    else
      render :action => :new
    end
  end

  def complete
    @todo = @list.todos.find(params[:id])
    @todo.update_column :completed, true
    redirect_to @list, :notice => 'Todo successfully marked as completed.'
  end

  def destroy
    @todo = @list.todos.find(params[:id])
    @todo.destroy
    redirect_to @list, :notice => 'Todo successfully destroyed.'
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end
end
