if Rails.env.test?
  Capybara.register_driver :headless_chrome do |app|
    chrome_options = { 'args' => ['headless', 'disable-gpu', 'no-sandbox'] }

    if chrome_bin = ENV['CHROME_BIN']
      chrome_options.merge!('binary' => chrome_bin)
    end

    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      "chromeOptions" => chrome_options
    )

    driver = Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: caps
    )
  end
end
