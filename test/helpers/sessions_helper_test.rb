require "test_helper"

class SessionsHelperTest < ActionView::TestCase 

  def setup 
    @user = users(:benard)
    remember(@user)
  end

  test "current_user return right user when sessions is nil" do 
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current user return nil when remeber_digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end