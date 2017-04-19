require 'test_helper'

class MascotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mascot = mascots(:one)
  end

  test "should get index" do
    get mascots_url
    assert_response :success
  end

  test "should get new" do
    get new_mascot_url
    assert_response :success
  end

  test "should create mascot" do
    assert_difference('Mascot.count') do
      post mascots_url, params: { mascot: { classification: @mascot.classification, name: @mascot.name } }
    end

    assert_redirected_to mascot_url(Mascot.last)
  end

  test "should show mascot" do
    get mascot_url(@mascot)
    assert_response :success
  end

  test "should get edit" do
    get edit_mascot_url(@mascot)
    assert_response :success
  end

  test "should update mascot" do
    patch mascot_url(@mascot), params: { mascot: { classification: @mascot.classification, name: @mascot.name } }
    assert_redirected_to mascot_url(@mascot)
  end

  test "should destroy mascot" do
    assert_difference('Mascot.count', -1) do
      delete mascot_url(@mascot)
    end

    assert_redirected_to mascots_url
  end
end
