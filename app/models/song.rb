class SongValidator < ActiveModel::Validator
  def validate(record)
    bad_titles  = Song.all.select{|s| s.title == record.title && s.artist_name == record.artist_name && s.release_year == record.release_year}
    if bad_titles != []
      record.errors[:title] << "Song title cannot be repeated by the same artist in the same year"
    end
    if record.released == true
      if record.release_year == nil
        record.errors[:release_year] << "Release year must be provided if song has been released"
      end
    end
    if record.release_year != nil && record.release_year > 2018
      record.errors[:release_year] << "Release year must not be in the future"
    end
  end
end

class Song < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with SongValidator
  validates :title, presence: true
  validates :released, inclusion: {in: [true, false]}
  #validates :release_year, numericality: {less_than_or_equal_to: 2018}
  validates :artist_name, presence: true
end
