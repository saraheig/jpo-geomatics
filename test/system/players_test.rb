require 'application_system_test_case'
require_relative '../helpers/authorization_helper'

class PlayersTest < ApplicationSystemTestCase
  include AuthorizationHelper

  setup do
    @player = players(:one)
    @user = users(:one)
  end

  test 'visiting the index' do
    visit players_url
    assert_selector 'h2', text: 'Classement du Grand Concours EC+G'
  end

  test 'creating a Player' do
    sign_up_user
    click_on 'Ajouter un nouveau joueur'

    fill_in 'player[pseudo]', with: 'PseudoNewPlayer'
    fill_in 'player[email]', with: @player.email
    fill_in 'player[score_gci]', with: @player.score_gci
    fill_in 'player[score_gen]', with: @player.score_gen
    fill_in 'player[score_geo]', with: @player.score_geo
    click_on 'Enregistrer'

    assert_text 'Le joueur a été créé.'
    click_on 'Retourner au classement'
    assert_selector 'tr td', text: 'PseudoNewPlayer'
    assert_selector 'tr td', text: @player.email
    assert_selector 'tr td', text: @player.score_gci
    assert_selector 'tr td', text: @player.score_gen
    assert_selector 'tr td', text: @player.score_geo

    # Disconnection of the user -> The player must not be present, as there is no value in score_geo
    click_on 'Se déconnecter'
    assert_text 'Déconnexion réussie'
    visit players_url
    assert_selector 'tr td', text: 'PseudoNewPlayer', count: 0
  end

  test 'updating a Player' do
    sign_up_user
    click_on 'Modifier', match: :first

    fill_in 'player[pseudo]', with: @player.pseudo
    fill_in 'player[email]', with: @player.email
    fill_in 'player[score_gci]', with: @player.score_gci
    fill_in 'player[score_gen]', with: @player.score_gen
    fill_in 'player[score_geo]', with: '1'
    click_on 'Enregistrer'

    assert_text 'Le joueur a été mis à jour.'
    click_on 'Retourner au classement'
    assert_selector 'tr td', text: @player.pseudo
    assert_selector 'tr td', text: @player.email
    assert_selector 'tr td', text: @player.score_gci
    assert_selector 'tr td', text: @player.score_gen
    assert_selector 'tr td', text: '1'

    # Disconnection of the user -> The player must be present, as there is a value in score_geo
    click_on 'Se déconnecter'
    assert_text 'Déconnexion réussie'
    visit players_url
    assert_selector 'tr td', text: @player.pseudo
  end

  private

  def sign_up_user
    visit new_session_url
    fill_in 'pseudo', with: @user.pseudo
    fill_in 'password', with: 'secret'
    click_on 'Se connecter'
    assert_text 'Connexion réussie'
  end
end
