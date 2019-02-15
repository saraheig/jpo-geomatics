class PlayersChannel < ApplicationCable::Channel

  def self.broadcast(player)
    ActionCable.server.broadcast(
      "PlayersChannel",
      { player: PlayersController.render(partial: 'players/player', locals: { player: player }) }
    )
  end

  def subscribed
    # stream_from "some_channel"
    stream_from "PlayersChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
