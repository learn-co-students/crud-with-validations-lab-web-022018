class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true
  validate :year_validator
  validate :year_validator_two

  def year_validator
    if self.released == true && self.release_year.nil?
      errors.add(:release_year, "no good bub")
    end
  end

  def year_validator_two
    if self.release_year
      if self.release_year > Time.now.year
        errors.add(:release_year, "no good bub")
      end
    end
  end

end
