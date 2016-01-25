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
