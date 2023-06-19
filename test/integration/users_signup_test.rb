require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup 
    ActionMailer::Base.deliveries.clear
  end
  
    test "the invalid sign up information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: {
        name: "",
        email: "example@invalid",
        password: "foo",
        password_confirmation: "bar"
       }
      }
    end
        assert_response :unprocessable_entity
        assert_template 'users/new'
   end

   test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: "Example User",
        email: "user@example.com",
        password: "example",
        password_confirmation: "example"
       }
      }
    end
        follow_redirect!
        #assert_template 'users/show'
        # assert is_logged_in?
        assert_not flash.empty?
   end
end
