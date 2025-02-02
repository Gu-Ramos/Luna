extends GameScreen
var cards : Array[Card] = []
var selected_card : Card

func _ready():
	#scale_fade()
	match Global.GAME.current_role:
		"judge":
			%Title.text = "Escolha uma carta preta."
		_:
			%Title.text = "Aguarde o juiz escolher uma carta."
	
	for card_info in Global.GAME.black_cards:
		var black_card : Card = Global.ELEMENTS[0].instantiate()
		black_card.update_card(0, card_info.text)
		black_card.pick = card_info.pick
		if Global.GAME.current_role == "judge":
			black_card.is_clickable = true
			black_card.connect("toggled", _on_card_clicked)
		%CardsContainer.add_child(black_card)
		cards.push_back(black_card)


func _on_card_clicked(toggled_on:bool, node:Card):
	if selected_card: selected_card.toggle(false)
	if toggled_on:
		selected_card = node
		%Select.show_fading()
	else:
		selected_card = null
		%Select.hide_fading()


#TODO: Select pressed
func _on_select_pressed():
	%Select.hide_fading()
	for black_card in cards:
		black_card.is_clickable = false
		#black_card.toggle(false)
