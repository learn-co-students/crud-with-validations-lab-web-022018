class Song < ActiveRecord::Base
  validates :title, presence: true

  with_options if: :released do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {less_than_or_equal_to: Time.now.year}
    song.validates :release_year, uniqueness: {scope: :title}
  end

end
