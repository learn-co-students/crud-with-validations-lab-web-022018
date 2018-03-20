class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: "cannot be repeated by the same artist in the same year"
  }
  validates :released, inclusion: {in: [true, false]}
  validates :released, exclusion: {in: [nil]}
  validates :artist_name, presence: true
  validate  :song_is_not_yet_released, :release_year_is_in_the_future

  def song_is_not_yet_released
    if released == true && release_year == nil
      errors.add(:release_year, "can't be blank")
    end
  end

  def release_year_is_in_the_future
    if release_year.to_i > Date.today.year
      errors.add(:release_year, "can't be a future year")
    end
  end

end
