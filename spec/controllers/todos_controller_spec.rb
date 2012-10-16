require 'spec_helper'

describe TodosController do
  let(:list) { List.create!(:name => 'my list')}

  describe 'get new' do
    it 'should be success' do
      get :new, :list_id => list.to_param
      response.should be_success
    end

    it 'assigns list as @list' do
      get :new, :list_id => list.to_param
      assigns(:list).should == list
    end
  end

  describe 'post create' do
    context 'with valid params' do
      it 'creates a new todo' do
        expect do
          post :create, :list_id => list.to_param, :todo => {:name => 'a todo'}
        end.to change(Todo, :count).by(1)
      end

      it 'redirects to the list show page' do
        post :create, :list_id => list.to_param, :todo => {:name => 'a todo'}
        response.should redirect_to(list)
      end
    end

    context 'with invalid params' do
      it 'doesnt creates a new todo' do
        expect do
          post :create, :list_id => list.to_param, :todo => {}
        end.not_to change(Todo, :count)
      end

      it 'renders the todos/new template' do
        post :create, :list_id => list.to_param, :todo => {}
        response.should render_template('todos/new')
      end
    end
  end

  describe 'put complete' do
    let(:todo) { Todo.create(:list => list, :name => 'wash dishes')}

    it 'assings todo as @todo' do
      put :complete, :list_id => list.to_param, :id => todo.to_param
      assigns(:todo).should == todo
    end

    it 'changes todo status to completed' do
      expect do
        put :complete, :list_id => list.to_param, :id => todo.to_param
        todo.reload
      end.to change(todo, :completed).to(true)
    end

    it 'redirects to the list show page' do
      put :complete, :list_id => list.to_param, :id => todo.to_param
      response.should redirect_to(list)
    end
  end

  describe 'delete destroy' do
    let(:todo) { Todo.create(:list => list, :name => 'wash dishes')}

    it 'assigns todo as @todo' do
      delete :destroy, :list_id => list.to_param, :id => todo.to_param
      assigns(:todo).should == todo
    end

    it 'destroys the todo' do
      delete :destroy, :list_id => list.to_param, :id => todo.to_param
      lambda {todo.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the list show page' do
      delete :destroy, :list_id => list.to_param, :id => todo.to_param
      response.should redirect_to(list)
    end
  end
end
