require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "should get registration" do
    get users_registration_url
    assert_response :success
  end

  test "should get authorization" do
    get users_authorization_url
    assert_response :success
  end

  test "should get profile" do
    get '/users/profile/1'
    assert_response :success
  end

  test "should get change user" do
    post '/users/authorization', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "email"=>"aaa@gmail.com", 
      "password"=>"12341234",  
      "commit"=>"Войти"}
    get '/users/change'
    assert_response :success
  end

  test "should log in" do
    post '/users/authorization', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "email"=>"aaa@gmail.com", 
      "password"=>"12341234",  
      "commit"=>"Войти"}
      assert_redirected_to root_url
  end

  test "should log out" do
    post '/users/logout', params: 
      {"authenticity_token"=>"[FILTERED]"}
      assert_redirected_to root_url
  end

  test "should create user" do
    assert_difference('User.count') do
      post '/users/registration', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "name"=>"Eeeee", 
      "email"=>"asfgwsegen@gmail.com", 
      "password"=>"[FILTERED]", 
      "password_rep"=>"[FILTERED]", 
      "commit"=>"Зарегистрироваться"}
    end
    assert_redirected_to root_url
  end

  test "should delete user" do
    assert_difference('User.count', -1) do
      get '/users/profile/1'
      post '/users/delete', params: 
      {"authenticity_token"=>"[FILTERED]"}
      get '/users/profile/2'
      post '/users/delete', params: 
      {"authenticity_token"=>"[FILTERED]"}
    end
    assert_redirected_to root_url
  end

end
