class_name CardContainer
extends Control

var cards : Array[Card] = []


func _ready():
	await %Base.resized
	%Control.scale = get_card_scale()

func _on_resized():
	%Control.scale = get_card_scale()

func add_card(node : Card) -> void:
	%Control.add_child(node)
	%Control.scale = get_card_scale()
	await node.finished
	var posy = 0
	for card in cards:
		posy += 54 * card.get_card_scale().y + min(686, card.get_text_size())
	node.position.y = posy

	cards.append(node)


func create_cards():
	for card_text in Global.GAME.white_cards[0]:
		var white_card = Global.ELEMENTS[0].instantiate()
		white_card.update_card(1, card_text)
		add_card(white_card)


func get_card_scale():
	if cards.front():
		return cards[0].get_card_scale()
	elif size.y/size.x <= 812.0/534.0: # this fixes 3 cards in choose_black
		return Vector2(size.y/812, size.y/812)
	else:
		return Vector2(size.x/534, size.x/534)


func get_container_size():
	if cards.back():
		return (cards.back().position.y + 812) * get_card_scale()
	else:
		return 812 * get_card_scale()
