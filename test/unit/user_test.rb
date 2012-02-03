require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "there are three users" do
    assert_equal 3, User.count 
  end
  
  test "User has 3 role attributes" do
    assert User.new.respond_to?(:role_one)
    assert User.new.respond_to?(:role_two)
    assert User.new.respond_to?(:role_three)
  end
  
  test "User has a password attribute" do
    assert User.new.respond_to?(:encrypted_password)
  end
  
  test "User has a username attribute" do
    assert User.new.respond_to?(:username)
  end
  
  test "User password is encrypted" do
    u = User.create(:username => "foobar", :password => "password", :password_confirmation => "password")
    assert_equal Digest::SHA1.hexdigest("password"), u.encrypted_password
  end
  
  test "Can't create a user without a password" do
    u = User.create(:username => "foobar")
    assert_equal u.errors.first.first, :password
    assert_equal "is too short (minimum is 6 characters)", u.errors.first.last
  end
  
  test "Short password is rejected" do
    u = User.create(:username => "foobar", :password => "pass", :password_confirmation => "pass")  
    assert_equal u.errors.first.first, :password
    assert_equal "is too short (minimum is 6 characters)", u.errors.first.last
  end
  
  test "Long password is rejected" do
    u = User.create(:username => "foobar", :password => "passwordpasswordpasswordpa", :password_confirmation => "passwordpasswordpasswordpa")
    assert_equal u.errors.first.first, :password
    assert_equal "is too long (maximum is 25 characters)", u.errors.first.last
  end

  test "Password change must be confirmed" do
    u = User.create(:username => "foobar", :password => "password", :password_confirmation => "pasword")
    assert_equal u.errors.first.first, :password
    assert_equal "doesn't match confirmation", u.errors.first.last
  end
  
  
  test "Can't create a user without a username" do
    u = User.create(:password => "password", :password_confirmation => "password")
    assert_equal u.errors.first.first, :username
    assert_equal "is too short (minimum is 3 characters)", u.errors.first.last
  end
  
  test "Short username is rejected" do
    u = User.create(:username => "fo", :password => "password", :password_confirmation => "password")
    assert_equal u.errors.first.first, :username
    assert_equal "is too short (minimum is 3 characters)", u.errors.first.last
  end
  
  test "Long username is rejected" do
    u = User.create(:username => "foobarfoobarfoobarfoobarfo", :password => "password", :password_confirmation => "password")
    assert_equal u.errors.first.first, :username
    assert_equal "is too long (maximum is 25 characters)", u.errors.first.last
  end
   
  test "Can change user's password" do
    u = User.find(users(:one).id)
    old_encrypted_password = u.encrypted_password
    u.password = "foobarpass"
    u.password_confirmation = "foobarpass"
    u.save
    assert u.errors.empty?
    assert_not_equal old_encrypted_password, User.find(users(:one).id).encrypted_password
    assert_equal Digest::SHA1.hexdigest("foobarpass"), User.find(users(:one).id).encrypted_password
  end

  test "Can't remove user's password" do
    u = User.find(users(:one).id)
    old_encrypted_password = u.encrypted_password
    u.password = nil
    u.password_confirmation = nil
    u.save
    assert u.errors.empty?
    assert_equal old_encrypted_password, User.find(users(:one).id).encrypted_password
  end

  test "Can't set user password to empty string" do
    u = User.find(users(:one).id)
    old_encrypted_password = u.encrypted_password
    u.password = ""
    u.password_confirmation = ""
    u.save
    assert u.errors.empty?
    assert_equal old_encrypted_password, User.find(users(:one).id).encrypted_password
  end
  
  test "Can Change user's roles" do
    u = User.find(users(:one).id)
    old_role_one = u.role_one
    u.role_one = !old_role_one
    u.save
    assert u.errors.empty?
    assert_not_equal old_role_one, User.find(users(:one).id).role_one
    assert_equal !old_role_one, User.find(users(:one).id).role_one
  end
   
end
