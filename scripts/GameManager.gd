extends Node3D

func _ready():
	var game = Game.new()

	game.start_game()
