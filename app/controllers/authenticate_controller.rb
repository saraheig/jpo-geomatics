class AuthenticateController < ApplicationController
  before_action :authenticate!

  private

  def authenticate!
    unless current_user
      redirect_to new_session_path, notice: 'Veuillez vous connecter pour modifier les données.'
    end
  end
end
