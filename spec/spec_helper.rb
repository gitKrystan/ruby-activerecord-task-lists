ENV['RACK_ENV'] = 'test'

require "rspec"
require "pg"
require "sinatra/activerecord"
require "list"
require "task"
require "pry"

RSpec.configure do |config|
  config.after(:each) do
    Task.all().each() do |task|
      task.destroy()
    end
    List.all().each() do |list|
      list.destroy()
    end
  end
end

def create_test_list
  List.create({
    :name => 'list'
    })
end

def create_second_list
  List.create({
    :name => 'list2'
    })
end

def create_test_task(list_id)
  Task.create({
    :description => 'test task',
    :list_id => list_id
    })
end
