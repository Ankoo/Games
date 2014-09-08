require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test 'username should exist' do
    user = User.new(email:'test@test.test', password_digest:'password')
    assert_equal false, user.save, 'user saved without name'
    assert user.errors.messages[:name], 'no errors on name'
  end
  
  test 'email should exist' do
    user = User.new(name:'test', password_digest:'password')
    assert_equal false, user.save, 'user saved without email'
    assert user.errors.messages[:email], 'no errors on email'
  end
  
  test 'password should exist' do
    user = User.new(name:'test', email:'test@test.test')
    assert_equal false, user.save, 'user saved without password'
    assert user.errors.messages[:password_digest], 'no errors on password'
  end
  
  test 'everything is fine' do
    user = User.new(name:'test', email:'test@test.test', password_digest:'password')
    assert_equal true, user.save, 'user not saved'
    assert_equal false, user.errors.messages, 'errors on user'
  end
  
end
