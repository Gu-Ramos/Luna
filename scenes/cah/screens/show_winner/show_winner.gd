extends GameScreen
var selected_card : Card


func _ready():
	if len(Global.GAME.white_cards) > 1:
		%Title.text = "DEU EMPATE!"
	else:
		%Title.text = Global.GAME.extra_info.winners[0] + " ganhou a rodada!"
	
	var black_card = Global.ELEMENTS[0].instantiate()
	black_card.update_card(0, Global.GAME.black_cards[0].text)
	black_card.pick = Global.GAME.black_cards[0].pick
	%CardsContainer.add_child(black_card)
	
	var white_group : CardContainer = Global.ELEMENTS[1].instantiate()
	for card_text in Global.GAME.white_cards[0]:
		var white_card = Global.ELEMENTS[0].instantiate()
		white_card.update_card(1, card_text)
		white_group.add_card(white_card)
	%CardsContainer.add_child(white_group)


#TODO: Select pressed
func _on_next_pressed():
	%Next.hide_fading()
