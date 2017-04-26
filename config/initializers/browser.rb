if Rails.env.test?
  def find_chrome_bin
    potential_binaries = [
      'chromium-browser',
      'chromium',
      'google-chrome-canary',
      'google-chrome-unstable',
      'google-chrome-beta',
      'google-chrome-stable',
      'google-chrome'
    ]

    potential_paths = [
      '/Applications/Chromium.app/Contents/MacOS/Chromium',
      "#{ENV['HOME']}/Applications/Chromium.app/Contents/MacOS/Chromium",
      '/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary',
      "#{ENV['HOME']}/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary",
      '/Applications/Google Chrome Beta.app/Contents/MacOS/Google Chrome Beta',
      "#{ENV['HOME']}/Applications/Google Chrome Beta.app/Contents/MacOS/Google Chrome Beta",
    ]

    potential_binaries.map do |bin|
      path = `which #{bin}`.strip
      Pathname.new(path).realpath.to_s if path.present?
    end.concat(potential_paths.select do |path|
      Pathname.new(path).realpath.to_s if File.exist?(path)
    end).compact.first
  end

  Capybara.register_driver :headless_chrome do |app|
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'args' => ['headless', 'disable-gpu', 'no-sandbox'],
        'binary' => ENV['CHROME_BIN'] || find_chrome_bin
      }
    )

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: caps
    )
  end
end
