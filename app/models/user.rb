class User < ApplicationRecord
  has_secure_password

  validates_presence_of :pseudo, message: 'Le pseudo de l\'utilisateur doit être spécifié.'
  validates_uniqueness_of :pseudo, case_sensitive: false, message: 'Le pseudo de l\'utilisateur est déjà utilisé.'
  validates_presence_of :password, message: 'Le mot de passe de l\'utilisateur doit être spécifié.'
end
