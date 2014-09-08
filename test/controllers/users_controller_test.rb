require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test 'get index of users' do
    get :index
    assert_response :success
    assert_equal User.all, assigns(:users)
    assert_template :index
  end
  
end
