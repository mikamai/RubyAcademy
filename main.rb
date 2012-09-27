require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Task
  include DataMapper::Resource  
  property :id,           Serial
  property :name,         String
  property :completed_at, DateTime
end


get "/" do
  erb :index
end

# View a task
get '/task/:id' do
  @task = Task.get(params[:id])
  erb :task
end

DataMapper.auto_upgrade!
