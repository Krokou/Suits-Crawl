extends Button

class_name CardDisplay

@export var index : int

@onready var button = $"."

func _ready():
	button.disabled = true
	button.text = ""



func update_card(card: Game.Card):
	var type = ""
	match card.type:
		0:
			type = "Monster"
			button.modulate = Color.WHITE
		1:
			type = "Potion"
			button.modulate = Color.RED
		2:
			type = "Weapon"
			button.modulate = Color.AQUA
		_:
			type = ""

	var value = str(card.value)

	var combined_text = type + "\n\n" + value

	button.text = combined_text
	button.disabled = false



func clear_text():
	button.text = ""
	button.disabled = true
	button.modulate = Color.GRAY
