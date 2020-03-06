require 'test_helper'
require_relative '../helpers/authorization_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @player = players(:one)
    @user = users(:one)
  end

  test 'should get index' do
    get players_url
    assert_response :success
  end

  test 'should not get new if not connected' do
    get new_player_url
    assert_redirected_to new_session_url
  end

  test 'should get new if connected' do
    sign_up_user
    get new_player_url
    assert_response :success
  end

  test 'should not create player if not connected' do
    assert_difference('Player.count', difference = 0) do
      post players_url, params: { player: { pseudo: 'MyString3', email: @player.email, score_gci: @player.score_gci, score_gen: @player.score_gen, score_geo: @player.score_geo } }
    end

    assert_redirected_to new_session_url
  end

  test 'should create player if connected' do
    sign_up_user
    assert_difference('Player.count') do
      post players_url, params: { player: { pseudo: 'MyString3', email: @player.email, score_gci: @player.score_gci, score_gen: @player.score_gen, score_geo: @player.score_geo } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test 'should not show player if not connected' do
    get player_url(@player)
    assert_redirected_to new_session_url
  end

  test 'should show player if connected' do
    sign_up_user
    get player_url(@player)
    assert_response :success
  end

  test 'should not get edit if not connected' do
    get edit_player_url(@player)
    assert_redirected_to new_session_url
  end

  test 'should get edit if connected' do
    sign_up_user
    get edit_player_url(@player)
    assert_response :success
  end

  test 'should not update player if not connected' do
    patch player_url(@player), params: { player: { pseudo: 'MyString4', email: @player.email, score_gci: @player.score_gci, score_gen: @player.score_gen, score_geo: @player.score_geo } }
    assert_redirected_to new_session_url
  end

  test 'should update player if connected' do
    sign_up_user
    patch player_url(@player), params: { player: { pseudo: 'MyString4', email: @player.email, score_gci: @player.score_gci, score_gen: @player.score_gen, score_geo: @player.score_geo } }
    assert_redirected_to player_url(@player)
  end

  private

  def sign_up_user
    user = { pseudo: @user.pseudo, password: @user.password }
    sign_up(user)
    assert_equal 'Connexion réussie', flash[:notice]
  end
end
