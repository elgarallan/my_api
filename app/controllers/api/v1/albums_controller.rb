class Api::V1::AlbumsController < ApplicationController
  before_action :set_artist
  before_action :set_album, only: [ :show, :update, :destroy ]

  def index
    render json: @artist.albums
  end

  def show
    render json: @album
  end

  def create
    album = @artist.albums.build(album_params)
    if album.save
      render json: album, status: :created
    else
      render json: album.errors, status: :unprocessable_entity
    end
  end

  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    head :no_content
  end

  private

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def set_album
    @album = @artist.albums.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :release_date)
  end
end
