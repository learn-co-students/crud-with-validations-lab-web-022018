class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.valid?
      @song.save
      redirecto_to @song
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

private

  def song_params(*args)
    params.require(:song).permit(*args)
  end


end
