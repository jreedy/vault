require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get edit" do
    get :edit, :id => @user
    assert_response :success
  end

  test "should update user" do
    updated_user = @user.attributes.slice('username', 'role_one', 'role_two', 'role_three')
    updated_user['password'] = 'mypassword'
    updated_user['password_confirmation'] = 'mypassword'
    put :update, :id => @user, :user => updated_user
    assert_response :redirect
    assert_redirected_to users_path()
    assert assigns(:user)
    assert_equal Digest::SHA1.hexdigest('mypassword'), User.find(@user.id).encrypted_password
  end

end
