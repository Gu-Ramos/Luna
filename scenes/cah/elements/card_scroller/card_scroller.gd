class_name CardScroller
extends Control


var cards : Array[Card] = []

#region Base
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
#endregion

#region Auxiliary
func insert_card(node : Card):
	cards.push_back(node)

func update_cards():
	pass
#endregion
