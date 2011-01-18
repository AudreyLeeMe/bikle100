require 'test_helper'

class PredictionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get fx" do
    get :fx
    assert_response :success
  end

  test "should get usstock" do
    get :usstock
    assert_response :success
  end

end
