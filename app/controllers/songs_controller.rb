class SongsController < ApplicationController
  load_and_authorize_resource
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index]
  # GET /songs
  # GET /songs.json
  def index
    if params[:user_id].nil?
    @user =current_user
  else
    @user=User.find(params[:user_id])

  end

    if params[:genre].nil?
    @songs = Song.all
  else
    @songs = Song.where(:genre_id =>params[:genre].to_i)
  end

    unless params[:ordenar].nil?
      if params[:ordenar]=="Ascendente"
        @songs = Song.order(name: :asc)
      else
        @songs = Song.order(name: :desc)
      end
  end

  end

  def list

        @user =current_user

    if params[:genre].nil?
    @songs = Song.all
  else
    @songs = Song.where(:genre_id =>params[:genre].to_i)
  end

    unless params[:ordenar].nil?
      if params[:ordenar]=="Ascendente"
        @songs = Song.order(name: :asc)
      else
        @songs = Song.order(name: :desc)
      end
  end



  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @genres=Genre.all

    @buscador_genre=[]
    @genres.each do |gen|

      @aux_buscador=[gen.name,gen.id]
      @buscador_genre.push(@aux_buscador)
    end

    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
   @genres=Genre.all

    @buscador_genre=[]
    @genres.each do |gen|

      @aux_buscador=[gen.name,gen.id]
      @buscador_genre.push(@aux_buscador)
    end
  
  end

  def agregar_cancion

    @user=User.find(params[:user][:user_id].to_i)

    if @user.id ==current_user.id
    song = Song.where(:id => params[:user][:song_ids])
    @user.songs = song
    @user.save 
    end

    redirect_to user_songs_path(:user_id=>@user.id)
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :duration,:genre_id)
    end
end
