require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "pg"
require "./lib/list"
require "./lib/task"
require "pry"

get('/') do
  @lists = List.all()
  @done_task_visibility = params[:done_task]

  erb(:index)
end

post('/lists') do
  List.create({
    :name => params[:name]
    })
  redirect('/')
end

delete('/lists') do
  list = List.find(params[:list_id])
  list.destroy()
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
  done = params[:done]
  if done == "done"
    task.update(done: 't')
  elsif done == "not_done"
    task.update(done: 'f')
  else
    list_id = params[:list_id]
    task.update(list_id: list_id)
  end

  redirect('/')
end
