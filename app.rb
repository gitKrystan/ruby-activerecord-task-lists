require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "pg"
require "./lib/list"
require "./lib/task"
require "pry"

get('/') do
  @lists = List.all()
  erb(:index)
end

post('/lists') do
  List.create({
    :name => params[:name]
    })
  redirect('/')
end

post('/tasks') do
  list = List.find(params[:list_id])
  list.tasks.create({
    :description => params[:description]
    })
  redirect('/')
end

patch('/tasks') do
  task = Task.find(params[:task_id])
  done_button_action = params[:done]
  if done_button_action == "clicked"
    task.update(done: 't')
  elsif done_button_action.nil?
    list_id = params[:list_id]
    task.update(list_id: list_id)
  end

  redirect('/')
end
