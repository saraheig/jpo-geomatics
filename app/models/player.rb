class Player < ApplicationRecord
  before_validation :strip_blanks

  validates_presence_of :pseudo, :message => 'Le pseudo du joueur doit être spécifié.'
  validates_uniqueness_of :pseudo, :case_sensitive => false, :message => 'Le pseudo du joueur est déjà utilisé.'
  validates_length_of :pseudo, :maximum => 25, :message => 'Le pseudo du joueur doit avoir maximum 25 caractères.'

  validates_presence_of :email, :message => 'L\'e-mail du joueur doit être spécifié.'
  validates_length_of :email, :maximum => 50, :message => 'L\'e-mail du joueur doit avoir maximum 50 caractères.'

  validates_numericality_of :score_geo, :allow_nil => true, :less_than_or_equal_to => 32767, :message => 'Le score géomatique du joueur doit valoir maximum 32767.'
  validates_numericality_of :score_geo, :allow_nil => true, :greater_than_or_equal_to => 0, :message => 'Le score géomatique du joueur doit valoir minimum 0.'

  validates_numericality_of :score_gci, :allow_nil => true, :less_than_or_equal_to => 32767, :message => 'Le score génie civil du joueur doit valoir maximum 32767.'
  validates_numericality_of :score_gci, :allow_nil => true, :greater_than_or_equal_to => 0, :message => 'Le score génie civil du joueur doit valoir minimum 0.'

  # Fuction to remove spaces in the fields
  def strip_blanks
    self.pseudo = self.pseudo.strip
    self.email = self.email.strip
  end

  # Function search to search a keyword through a form
  def self.search(keyword)
    if keyword
      where("pseudo iLIKE :term OR email iLIKE :term", term: "%#{keyword}%").order(updated_at: :desc)
      # iLIKE -> case insensitive
    else
      all.order(updated_at: :desc)
    end
  end
end
