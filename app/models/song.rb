# require 'pry'
# require 'ActiveModel'
class SongValidator < ActiveModel::Validator
  def validate(record)
    #invalid unless
    # unless ( !record[:release_year].nil? && record[:released]==true) || (record[:released] == false )
    #   record.errors[:release_year] << "release_year cant be empty if released true. release_year:#{record[:release_year]} and released:#{record[:released]}"
    # end
    # http://guides.rubyonrails.org/active_record_validations.html
    # if record[:released]==true && record[:release_year].nil?
    if record.released==true && record.release_year == nil
        record.errors[:release_year] << "release_year cant be empty if released true. release_year:#{record[:release_year]} and released:#{record[:released]}"
    end
    # if record.released==false  && record.release_year == nil
    if record.release_year.to_i >  Date.today.year.to_i
      record.errors[:release_year] << "Future release cant be listed"
    end
    song_title_by_artist_present = false
    # title =nilt
    # song_title_by_artist_present = false
    # binding.pry
    # Song.all do |s|
    #   # title=s.title
    #   # binding.pry
    #   # song_title_by_artist_present = true if ( s.title == record.title && s.artist_name == record.artist_name && s.release_year == record.release_year)
    #   if s.title == record.title
    #     # binding.pry
    #     if s.artist_name == record.artist_name
    #       if  s.release_year == record.release_year
    #         # binding.pry
    #         song_title_by_artist_present = true
    #       end#release_year
    #     end#artist_name
    #   end#title
    # end #do
    
    duplicate = Song.find_by(title: record.title,release_year: record.release_year, artist_name: record.artist_name)
    if duplicate
      record.errors[:release_year] << "only one title of same name per year, release cant be listed"
    end
    # binding.pry
  end#validate
end#class


class Song < ActiveRecord::Base
  validates :title, presence: true   #   Must not be blank
  # validates :title, format: string  # title, a string ??????????
  # validates :released, presence: true
  validates :artist_name, presence: true  #   artist_name, a string  Must not be blank
  include ActiveModel::Validations
  validates_with SongValidator



end #end class
