require 'test_helper'

class R10ControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get blog" do
    get :blog
    assert_response :success
  end

  test "should get forex" do
    get :forex
    assert_response :success
  end

end
