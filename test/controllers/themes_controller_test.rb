require "test_helper"

class ThemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @theme1 = themes(:one)
    @theme2 = themes(:two)
    @answer1 = answers(:one)
    @answer2 = answers(:two)
  end
  test "should get main" do
    get '/themes/main'
    assert_response :success
  end

  test "should get theme" do
    get '/themes/show/2'
    assert_response :success
  end

  test "should get create theme" do
    get '/themes/create'
    assert_response :success
  end

  test "should create theme" do
    assert_difference('Theme.count') do
      post '/users/authorization', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "email"=>"aaa@gmail.com", 
      "password"=>"12341234",  
      "commit"=>"Войти"}

      post '/themes/create', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "title"=>"Aaaaaaa", 
      "text"=>"aaaaaaaa", 
      "commit"=>"Отправить"}
    end

  end

  test "should delete theme" do
    assert_difference('Theme.count', -1) do
      get '/themes/show/1'
      post '/themes/delete', params: 
      {"authenticity_token"=>"[FILTERED]"}
    end
    assert_redirected_to root_url
  end

  test "should create answer" do
    assert_difference('Answer.count') do
      post '/users/authorization', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "email"=>"aaa@gmail.com", 
      "password"=>"12341234",  
      "commit"=>"Войти"}
      assert_redirected_to root_url

      get '/themes/show/1'

      post '/themes/create_ans', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "text"=>"ssssssssssssssss", 
      "commit"=>"Ответить"}
    end
    assert_redirected_to '/ru/themes/show/1'
  end

  test "should delete answer" do
    assert_difference('Answer.count', -1) do
      get '/themes/show/1'
      post '/themes/delete_ans', params: 
      {"authenticity_token"=>"[FILTERED]", 
      "id"=>"2"}
    end
    assert_redirected_to '/ru/themes/show/1'
  end
end
