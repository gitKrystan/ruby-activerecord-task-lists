require('capybara/rspec')
require('./app')
require('./spec/spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

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

describe('adding a list', {:type => :feature}) do
  it('allows the user to add multiple lists to a board') do
    visit('/')
    fill_in('name', :with => 'Test List')
    click_button('save-new-list')
    expect(page).to(have_content('Test List'))
    fill_in('name', :with => 'Test List 2')
    click_button('save-new-list')
    expect(page).to(have_content('Test List 2'))
  end
end

describe('adding a task', {:type => :feature}) do
  it('allows the user to add multiple tasks to a list') do
    test_list = create_test_list()
    visit('/')
    fill_in("task-description-for-#{test_list.id()}", :with => 'Test task')
    click_button("save-task-to-#{test_list.id()}")
    expect(page).to(have_content('Test task'))
    fill_in("task-description-for-#{test_list.id()}", :with => 'Test task 2')
    click_button("save-task-to-#{test_list.id()}")
    expect(page).to(have_content('Test task 2'))
  end
end

describe('moving a task', {:type => :feature}) do
  it('allows the user to move a task to another list') do
    test_list = create_test_list()
    second_list = create_second_list()
    test_task = create_test_task(test_list.id())
    visit('/')
    select(second_list.name())
    click_button('Go')
    expect(second_list.tasks()).to(eq([test_task]))
  end
end

describe('completing a task', {:type => :feature}) do
  it('allows the user to hide completed tasks') do
    test_list = create_test_list()
    test_task = create_test_task(test_list.id())
    visit('/')
    click_button('Done')
    expect(page).not_to(have_content('task'))
  end
end
