extends CanvasLayer

class_name CardController

@export var cards : Array[CardDisplay]
@export var current_weapon : CardDisplay
@export var current_scewered : CardDisplay
@export var current_health : Label
@export var deck : Label



func _ready():
	pass



func update_room_display(current_room: Array[Game.Card]):
	for i in range(cards.size()):
		if i < current_room.size():
			cards[i].update_card(current_room[i])
		else:
			cards[i].clear_text()



func update_weapon_display(weapon: Game.Card):
	if weapon != null:
		current_weapon.update_card(weapon)
	else:
		current_weapon.clear_text()



func update_scewered_display(monster: Game.Card):
	if monster != null:
		current_scewered.update_card(monster)
	else:
		current_scewered.clear_text()



func update_health_display(health: int):
	current_health.text = "Health: " + str(health)



func update_deck_display(deck_size: int):
	deck.text = "Cards left: " + str(deck_size)



func toggle_weapon_display(disable: bool):
	current_weapon.disabled = disable

