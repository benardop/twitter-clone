require "test_helper"
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "Twitter Clone Sample Appplication", full_title
    assert_equal full_tile, full_title("Help")
  end
end