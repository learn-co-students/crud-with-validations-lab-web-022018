class DuplicateValidator < ActiveModel::Validator
  def validate(song)
    if Song.all.any? do |dupe|
      song.title == dupe.title && song.release_year == dupe.release_year && song.id != dupe.id
    end
      song.errors.add :base, "Cannot release the same song twice this year"
    end
  end
end

class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: {in: [true, false]}
  validates :release_year, presence: true, if: :is_released
  validates :release_year, numericality: {less_than_or_equal_to: Date.today.year}, if: :is_released
  validates_with DuplicateValidator

  def is_released
    released == true
  end

end
