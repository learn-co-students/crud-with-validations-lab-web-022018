class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.valid?
      @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def show
    set_song
  end

  def edit
    set_song
  end

  def update
    set_song
    @song.update(song_params)
    if @song.valid?
      @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    set_song
    @song.destroy
    redirect_to songs_path
  end

  private
  def song_params
    params.require(:song).permit(:title, :release_year, :released, :artist_name, :genre)
  end

  def set_song
    @song = Song.find(params[:id])
  end
end
