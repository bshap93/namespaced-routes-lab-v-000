class ArtistsController < ApplicationController
  before_action :set_preferences, only: [:new, :index]

  def index
    if @preference.artist_sort_order == "DESC"
      @artists = Artist.order("name DESC")
    elsif @preference.artist_sort_order == "ASC"
      @artists = Artist.order("name ASC")
    else
      @artists = Artist.all
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    if @preference.allow_create_artists
      @artist = Artist.new
    else
      redirect_to artists_path
    end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end

  def set_preferences
    @preference = Preference.first_or_create
  end
end
