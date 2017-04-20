if Rails.env.test?
  require "capybara"
  require "selenium-webdriver"

  def find_chrome
    potential_binaries = [
      'chromium-browser',
      'chromium',
      'google-chrome-canary', 
      'google-chrome-unstable',
      'google-chrome-stable',
      'google-chrome'
    ]

    potential_paths = [
      '/Applications/Chromium.app/Contents/MacOS/Chromium',
      "#{ENV['HOME']}/Applications/Chromium.app/Contents/MacOS/Chromium",
      '/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary',
      "#{ENV['HOME']}/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary",
      '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
      "#{ENV['HOME']}/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    ]

    potential_binaries.map do |bin|
      path = `which #{bin}`
      path if path.present?
    end.compact.concat(potential_paths.select do |path|
      File.exists?(path)
    end).first
  end

  Capybara.register_driver :headless_chrome do |app|
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      "chromeOptions" => {
        'binary' => ENV['CHROME_BIN'] || find_chrome,
        'args' => ['headless', 'disable-gpu']
      }
    )
    driver = Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: caps
    )
  end
end
