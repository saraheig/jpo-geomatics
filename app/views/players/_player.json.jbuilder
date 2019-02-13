json.extract! player, :id, :pseudo, :email, :score_geo, :score_gci, :created_at, :updated_at
json.url player_url(player, format: :json)
