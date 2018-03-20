class SongsController < ApplicationController
  def new
    @song = Song.new
  end

  def index
    @songs = Song.all
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to song_path(@song)
    else
      @errors = @song.errors
      render :new
    end
  end

  def show
    @song = Song.find(params[:id])
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    song_params.each do |key, val|
      @song.send(key + "=", val)
    end
    #@song.update(song_params)

    if @song.save
      redirect_to @song
    else
      @errors = @song.errors
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
  end
end
