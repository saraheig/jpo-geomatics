class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  def index
    keyword = params[:keyword]
    @players = Player.search(keyword)
  end

  # GET /players/1
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        # Connexion to the players channel
        PlayersChannel.broadcast(@player)

        format.html { redirect_to @player, notice: 'Le joueur a été créé.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /players/1
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Le joueur a été mis à jour.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Le joueur a été supprimé.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:pseudo, :email, :score_geo, :score_gci)
    end
end
