#= require ./game_data/game_data
#= require ./game_engine/game_engine
#= require_self

$(() ->
  game = new GameEngine.Game()
  game.start()
)
