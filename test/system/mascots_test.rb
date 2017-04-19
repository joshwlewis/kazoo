require "application_system_test_case"

class MascotsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit mascots_url
  
    assert_selector "h1", text: "Mascot"
  end
end
