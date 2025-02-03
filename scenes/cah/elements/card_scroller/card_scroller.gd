class_name CardScroller
extends ScrollContainer

var cards : Array[Card] = []


#region Base
func _ready():
	%HContainer.add_theme_constant_override("separation", (size.y/890.0)*24)
	print(size.y)
	for card_text in Global.GAME.player_cards:
		var white_card: Card = Global.ELEMENTS[0].instantiate()
		white_card.update_card(1, card_text)
		
		var card_holder: HCardContainer = Global.ELEMENTS[2].instantiate()
		card_holder.size_flags_horizontal = Control.SIZE_FILL
		card_holder.custom_minimum_size.x = size.y * (534.0 / 890.0)
		card_holder.size.y = size.y
		card_holder.bar_visible = true
		card_holder.bar_text = "1"
		card_holder.add_card(white_card)
		card_holder.add_card(white_card.duplicate())
		%HContainer.add_child(card_holder)
#endregion


#region Auxiliary
func insert_card(node : Card):
	cards.push_back(node)

func update_cards():
	pass
#endregion
