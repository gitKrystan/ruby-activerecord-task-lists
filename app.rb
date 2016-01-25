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
