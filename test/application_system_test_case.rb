require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--disable-gpu')
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  driven_by :chrome
end
