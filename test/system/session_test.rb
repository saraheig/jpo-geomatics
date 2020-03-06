require 'application_system_test_case'
require_relative '../helpers/authorization_helper'

class SessionTest < ApplicationSystemTestCase
  include AuthorizationHelper

  setup do
    @user = users(:one)
  end

  test 'can sign in as user and sign out' do
    # Test connection
    visit new_session_url
    fill_in 'pseudo', with: @user.pseudo
    fill_in 'password', with: 'secret'
    click_on 'Se connecter'
    assert_text 'Connexion réussie'

    # Test deconnection
    click_on 'Se déconnecter'
    assert_text 'Déconnexion réussie'
  end
end
