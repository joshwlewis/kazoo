require 'test_helper'

class MascotTest < ActiveSupport::TestCase

  test "mascots have names" do
    mascot = Mascot.first
    assert_kind_of String, mascot.name
  end

end
