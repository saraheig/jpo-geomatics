class Player < ApplicationRecord
  before_validation :strip_blanks

  validates_presence_of :pseudo, :message => 'Le pseudo du joueur doit être spécifié.'
  validates_uniqueness_of :pseudo, :case_sensitive => false, :message => 'Le pseudo du joueur est déjà utilisé.'
  validates_length_of :pseudo, :maximum => 25, :message => 'Le pseudo du joueur doit avoir maximum 25 caractères.'

  validates_presence_of :email, :message => 'L\'e-mail du joueur doit être spécifié.'
  validates_length_of :email, :maximum => 50, :message => 'L\'e-mail du joueur doit avoir maximum 50 caractères.'
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'Le format de l\'e-mail est incorrect.'

  validates_numericality_of :score_geo, :allow_nil => true, :less_than_or_equal_to => 100, :message => 'Le score géomatique du joueur doit valoir maximum 100.'
  validates_numericality_of :score_geo, :allow_nil => true, :greater_than_or_equal_to => 0, :message => 'Le score géomatique du joueur doit valoir minimum 0.'

  validates_numericality_of :score_gen, :allow_nil => true, :less_than_or_equal_to => 100, :message => 'Le score environnement du joueur doit valoir maximum 100.'
  validates_numericality_of :score_gen, :allow_nil => true, :greater_than_or_equal_to => 0, :message => 'Le score environnement du joueur doit valoir minimum 0.'

  validates_numericality_of :score_gci, :allow_nil => true, :less_than_or_equal_to => 100, :message => 'Le score génie civil du joueur doit valoir maximum 100.'
  validates_numericality_of :score_gci, :allow_nil => true, :greater_than_or_equal_to => 0, :message => 'Le score génie civil du joueur doit valoir minimum 0.'

  # Override a method used by as_json()
  def serializable_hash(options = nil)
    result = super(options)
    result['score_total'] = score_total
    return result
  end

  # Fuction to remove spaces in the fields
  def strip_blanks
    self.pseudo = self.pseudo.strip
    self.email = self.email.strip
  end

  # Function to calculate the total score
  def score_total
    if score_geo && score_gci && score_gen
      score_geo + score_gci + score_gen
    end
  end

  # Function search to search a keyword through a form
  def self.search(keyword, sort)
    if keyword
      where("pseudo iLIKE :term OR email iLIKE :term", term: "%#{keyword}%").order({ sort => :asc })
      # iLIKE -> case insensitive
    elsif sort == :score_total
      where("score_gci IS NOT NULL AND score_geo IS NOT NULL AND score_gen IS NOT NULL").order("score_gci + score_geo + score_gen DESC")
    else
      all.order({ sort => :asc })
    end
  end
end
