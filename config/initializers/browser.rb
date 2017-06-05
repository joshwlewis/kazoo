if Rails.env.test?
  Capybara.register_driver :headless_chrome do |app|
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'args' => ['headless', 'disable-gpu', 'no-sandbox'],
        'binary' => ENV['GOOGLE_CHROME_SHIM']
      }.reject { |k, v| v.nil? }
    )

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: caps
    )
  end
end
