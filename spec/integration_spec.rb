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
  it('allows the user to add a list to an empty board') do
    visit('/')
    fill_in('name', :with => 'Test List')
    click_button('Save')
    expect(page).to(have_content('Test List'))
  end
end
