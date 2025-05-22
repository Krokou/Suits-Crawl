class_name Game

var monster_count: int = 13
var potion_count: int = 9
var weapon_count: int = 9

var deck: Array[Card]
var current_room: Array[Card]
var discard_pile: Array[Card]

var equiped_weapon: Card
var scewered_monsters: Array[Card]
var player_health: int = 20

var has_avoided: bool = false

enum CARD_TYPE {MONSTER, POTION, WEAPON}

class Card:
	var type: CARD_TYPE
	var value: int

	func _init(_type: CARD_TYPE, _value: int):
		self.type = _type
		self.value = _value



func start_game():
	assert(deck.is_empty())

	for i in range(monster_count):
		deck.append(Card.new(CARD_TYPE.MONSTER, i + 1))
	for i in range(potion_count):
		deck.append(Card.new(CARD_TYPE.POTION, i + 1))
	for i in range(weapon_count):
		deck.append(Card.new(CARD_TYPE.WEAPON, i + 1))
	
	print("Printing deck")
	for i in deck:
		print("Card Type: ", i.type, " Value: ", i.value)
	print("")

	deck.shuffle()

	print("Printing shuffled deck")
	for i in deck:
		print("Card Type: ", i.type, " Value: ", i.value)
	print("")



func draw_room():
	assert(current_room.size() <= 1)
	assert(deck.size() >= 3)

	if has_avoided:
		has_avoided = false

	while current_room.size() < 4 and deck.size() > 0:
		var card = deck.pop_front()
		current_room.append(card)
	
	print("Printing current room")
	for i in current_room:
		print("Card Type: ", i.type, " Value: ", i.value)
	print("")



func discard_card(card: Card):
	assert(current_room.has(card))

	current_room.erase(card)
	discard_pile.append(card)
	print("Discarded card: ", card.type, " Value: ", card.value)
	print("")



func drink_potion(potion: Card):
	assert(potion.type == CARD_TYPE.POTION)

	player_health += potion.value
	if player_health > 20:
		player_health = 20

	print("Drank potion: ", potion.value)
	discard_card(potion)



func fight_monster(monster: Card, barehanded: bool):
	assert(monster.type == CARD_TYPE.MONSTER)

	var damage: int = 0

	if equiped_weapon != null && !barehanded:
		if scewered_monsters.size() != 0:
			if scewered_monsters[-1].value > monster.value:
				damage = monster.value - equiped_weapon.value
				if damage < 0:
					damage = 0
				player_health -= damage
				scewered_monsters.append(monster)
				current_room.erase(monster)
				return
			player_health -= monster.value
			discard_card(monster)
			return
		damage = monster.value - equiped_weapon.value
		if damage < 0:
			damage = 0
		player_health -= damage
		scewered_monsters.append(monster)
		current_room.erase(monster)
		return

	player_health -= monster.value
	discard_card(monster)



func equip_weapon(weapon: Card):
	assert(current_room.has(weapon))
	assert(weapon.type == CARD_TYPE.WEAPON)

	if equiped_weapon != null:
		discard_pile.append(equiped_weapon)

		for i in scewered_monsters:
			discard_pile.append(i)
		scewered_monsters.clear()
	
	equiped_weapon = weapon
	current_room.erase(weapon)

	print("Equiped weapon: ", weapon.value)



func avoid_room():
	assert(!has_avoided)

	for i in current_room:
		deck.append(i)
	current_room.clear()

	draw_room()
	has_avoided = true

