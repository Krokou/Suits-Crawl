extends Node3D

@export var card_controller: CardController
@export var avoid_button: Button

@onready var game = Game.new()
var fight_barehanded = false

func _ready():
	avoid_button.modulate = Color.FOREST_GREEN

	game.start_game()
	game.draw_room()

	card_controller.update_health_display(game.player_health)
	card_controller.update_deck_display(game.deck.size())
	card_controller.update_weapon_display(game.equiped_weapon)
	card_controller.update_scewered_display(game.scewered_monsters[-1] if game.scewered_monsters.size() > 0 else null)
	card_controller.update_room_display(game.current_room)



func _on_card_3_pressed() -> void:
	select_card(3)



func _on_card_2_pressed() -> void:
	select_card(2)



func _on_card_1_pressed() -> void:
	select_card(1)



func _on_card_0_pressed() -> void:
	select_card(0)



func _on_barehanded_toggle_toggled(toggled_on: bool) -> void:
	fight_barehanded = toggled_on
	card_controller.toggle_weapon_display(toggled_on)



func select_card(index: int):
	match game.current_room[index].type:
		0:
			game.fight_monster(game.current_room[index], fight_barehanded)
			card_controller.update_health_display(game.player_health)
			if game.scewered_monsters.size() > 0:
				card_controller.update_scewered_display(game.scewered_monsters[-1])
			else:
				card_controller.update_scewered_display(null)
		1:
			game.drink_potion(game.current_room[index])
			card_controller.update_health_display(game.player_health)
		2:
			game.equip_weapon(game.current_room[index])
			card_controller.update_weapon_display(game.equiped_weapon)
			card_controller.update_scewered_display(null)
		_:
			print("Invalid card type")
	
	avoid_button.disabled = true
	avoid_button.modulate = Color.BLACK

	if game.player_health <= 0:
		#TODO: Handle game over
		print("Game Over")
		pass

	if game.current_room.size() == 0 and game.deck.size() == 0:
		#TODO: Handle victory
		print("Victory!")
		pass

	if game.current_room.size() == 1 and game.deck.size() != 0:
		game.draw_room()
		avoid_button.modulate = Color.FOREST_GREEN
		avoid_button.disabled = false
		card_controller.update_deck_display(game.deck.size())
	
	card_controller.update_room_display(game.current_room)
	


func _on_avoid_pressed() -> void:
	avoid_button.modulate = Color.BLACK
	avoid_button.disabled = true
	game.avoid_room()
	card_controller.update_room_display(game.current_room)
