require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "benard", email: "benard@gmail.com", password: "foobar",
                      password_confirmation: "foobar")
  end
    test "should be valid" do
      assert @user.valid?
    end

    test "name should be present" do
      @user.name = " "
      assert_not @user.valid?
    end

    test "email should be present" do
      @user.email = " "
      assert_not @user.valid?
    end

    test "name should not be too long" do
      @user.name = "a" * 51
      assert_not @user.valid?
    end

    test "email should not be too long" do
      @user.email = "a" * 244 + "example@email.com"
    end

    test "email validation should accept valid email addresses" do
       valid_addresses = %w[user@example.com  USER@foo.COM  A_US-ER@foo.bar.org]

       valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
       end
    end

    test "email validation should reject invalid email addresses" do
      invalid_addresses = %w[example@email,com  foo@bar..com  A_USE_example.com  good_at_example.com]

      invalid_addresses.each do |invalid_address|
       @user.email = invalid_address
       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end
    
    test "email addresses should be unique" do
      duplicate_user = @user.dup
      @user.save
      assert_not duplicate_user.valid?
    end

    test "user email should be saved as lowercase" do
      mixed_case_email = "Foo@Example.Com"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
    end

    test "password should be presnt(non blank)" do
       @user.password = @user.password_confirmation = " " * 6
       assert_not @user.valid?
    end

    test "password should have a minimum length" do
       @user.password = @user.password_confirmation = "a" * 5
       assert_not @user.valid?
    end

    test "authenticated? should return false for user with nil digest" do 
      assert_not @user.authenticated?(:remember, '')
    end
end
