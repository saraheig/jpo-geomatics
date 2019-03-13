class PlayersChannel < ApplicationCable::Channel

  def self.broadcast(player)
    ActionCable.server.broadcast(
      "PlayersChannel",
      {
        scoreGeo: player.score_geo,
        scoreGci: player.score_gci,
        scoreGen: player.score_gen,
        pseudo: player.pseudo,
        id: player.id,
        player: player
      }
    )
  end

  def subscribed
    # stream_from "some_channel"
    stream_from "PlayersChannel" do |encoded_message|

      message = ActiveSupport::JSON.decode(encoded_message)
      player = message['player']

      # Replace player object by rendered template
      message['player'] = PlayersController.render(partial: 'players/player', locals: { player: player, logged_in: current_user.present? })
      transmit message
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
