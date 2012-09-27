# Ruby Academy Ottobre 2012 #

Installare RVM

Installare client GitHub

Installare Bundler

```bash
sudo gem install bundle
```

Installare SQlite

```bash
sudo aptitude install sqlite3 libsqlite3-ruby
```

Installare data mapper

```bash
sudo gem install data_mapper
```

Installare l'adapter per SQLite

```bash
sudo gem install dm-sqlite-adapter
```
* oppure *

usare bundler, quindi creare un file chiamato Gemfile nella cartella del progetto e metterci dentro

```ruby
source "http://rubygems.org"

gem 'sinatra', :require => "sinatra/base"
gem 'data_mapper'
gem 'dm-sqlite-adapter'
```

poi eseguire

```bash
bundle install
```
notare come con bundler non ci sia la necessità di usare sudo

Creare il file main.rb

Fare il require di bundler
Connettersi al Database

```ruby
require 'rubygems'
require 'bundler/setup'

require 'rubygems'
require 'sinatra'
require 'data_mapper'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Task
  include DataMapper::Resource  
  property :id,           Serial
  property :name,         String
  property :completed_at, DateTime
end

DataMapper.auto_upgrade!
```

Testare con irb il collegamento con il database

```bash
$> irb -r main.rb
```
```bash
$irb(main): > Task.all
=> []
```
```bash
$irb(main): > t = Task.new
=> #<Task @id=nil @name=nil @completed_at=nil>
```
```bash
$irb(main): > t.name = "Get milk"
=> "Get milk"
```
```bash
irb(main):007:0> t.save
=> true
```
```bash
irb(main):008:0> Task.first
=> #<Task @id=1 @name="Get milk" @completed_at=nil>
```

Aggiungiamo un po di CRUD via REST

# Visualizzazione di un task #

```ruby
# show task
get '/task/:id' do
  @task = Task.get(params[:id])
  erb :task
end
```

creare views/task.erb

```html
<h2><%= @task.name %></h2>
```
creare layout.erb

```html
<!DOCTYPE html>
<html lang="en">
<head>
<title>To Do List</title>
<meta charset=utf-8 />
</head>
<body>
<h1>To Do List</h1>

<%= yield %>

</body>
</html>
```

eseguire per testare

```bash
$> ruby main.rb
```

## Creazione di nuovi task ##

in main.rb aggiungere

```ruby
# new task
get '/task/new' do
  erb :new
end
```
questo codice va aggiunto * prima * di get '/task/:id' altrimenti sinatra penserà che "new" sia un id


creare new.erb con questo codice

```html
<form action="/task/create" method="POST">
  <input type="text" name="name" id="name">
  <input type="submit" value="Add Task!"/>
</form>
```
in main.rb creare l'azione che gestirà il POST dei dati

```ruby
# create new task   
post '/task/create' do
  task = Task.new(:name => params[:name])
  if task.save
    status 201
    redirect '/task/'+task.id.to_s  
  else
    status 412
    redirect '/tasks'   
  end
end
```

## Lista dei task ##

in main.rb

```ruby
# list all tasks
get '/tasks' do
  @tasks = Task.all
  erb :index
end
```

...e in index.erb

```html
<h2>Tasks:</h2>
<% unless @tasks.empty? %>
<ul>
<% @tasks.each do |task| %>
<li <%= "class=\"completed\"" if task.completed_at %>>
<a href="/task/<%=task.id%>"><%= task.name %></a>
</li>
<% end %>
</ul>
<% else %>
<p>No Tasks!</p>
<% end %>
```

## Modifica dei task esistenti ##

in main.rb

```ruby
# edit task
get '/task/:id/edit' do
  @task = Task.get(params[:id])
  erb :edit
end

# update task
put '/task/:id' do
  task = Task.get(params[:id])
  task.completed_at = params[:completed] ?  Time.now : nil
  task.name = (params[:name])
  if task.save
    status 201
    redirect '/task/'+task.id.to_s
  else
    status 412
    redirect '/tasks'   
  end
end
```

creaimo edit.erb

```html
<form action="/task/<%= @task.id %>" method="post">
<input name="_method" type="hidden" value="put" />
<input type="text" name="name" id="name" value="<%= @task.name %>">
<input id="completed" name="completed" type="checkbox" value="done" <%= @task.completed_at ? "checked" : "" %>/>
<input id="task_submit" name="commit" type="submit" value="Update" />
</form>
```

## Eliminazione dei task ##

in main.rb

```ruby
# delete confirmation
get '/task/:id/delete' do
  @task = Task.get(params[:id])
  erb :delete
end
```

in edit.erb aggiungiamo la riga
```html
<a href="/task/<%= @task.id %>/delete">Delete this task</a>
```
creiamo delete.erb

```html
<h2><%= @task.name %><h2>
<h3>Are you sure you want to delete this task?<h3>
<form action="/task/<%= @task.id %>" method="post">
<input type="hidden" name="_method" value="delete" />
<input type="submit" value="Delete">
 or <a href="/tasks">Cancel</a>
</form>
```

...e aggiungiamo il codice per l'eliminazione effettiva del record

```ruby
# delete task
delete '/task/:id' do
  Task.get(params[:id]).destroy
  redirect '/tasks'  
end
```

## Il codice completo di main.rb: ##

```ruby
require 'rubygems'
require 'bundler/setup'

require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Task
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String
  property :completed_at, DateTime
end

# list all tasks
get '/tasks' do
  @tasks = Task.all
  erb :index
end

# new task
get '/task/new' do
  erb :new
end

# show task
get '/task/:id' do
  @task = Task.get(params[:id])
  erb :task
end



# create new task   
post '/task/create' do
  task = Task.new(:name => params[:name])
  if task.save
    status 201
    redirect '/task/'+task.id.to_s   
  else
    status 412
    redirect '/tasks'   
  end
end

# edit task
get '/task/:id/edit' do
  @task = Task.get(params[:id])
  erb :edit
end

# update task
put '/task/:id' do
  task = Task.get(params[:id])
  task.completed_at = params[:completed] ?  Time.now : nil
  task.name = (params[:name])
  if task.save
    status 201
    redirect '/task/'+task.id.to_s
  else
    status 412
    redirect '/tasks'   
  end
end

# delete confirmation
get '/task/:id/delete' do
  @task = Task.get(params[:id])
  erb :delete
end

# delete task
delete '/task/:id' do
  Task.get(params[:id]).destroy
  redirect '/tasks'  
end

DataMapper.auto_upgrade!
```