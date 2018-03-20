require 'time'

class TitleValidator < ActiveModel::Validator

  def validate(song)
    songs = Song.all.select {|s| song.title == s.title && s.release_year == song.release_year && s.artist_name == song.artist_name}
    if songs != []
      song.errors[:name] << "Artist can't have multiple songs of the same name in a year"
    end

    if song.released
      if [song.release_year].empty? || song.release_year.nil?
        song.errors[:release_year] << "A released song must have a release year"
      elsif song.release_year > Time.now.year
        song.errors[:release_year] << "Release year must be before the current date"
      end
    end
  end

end




class Song < ActiveRecord::Base

  includes ActiveModel::Validator

  validates :title, presence: true
  validates :artist_name, presence: true


  validates_with TitleValidator



end
