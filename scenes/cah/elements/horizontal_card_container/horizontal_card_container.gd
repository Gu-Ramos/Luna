class_name HCardContainer
extends Control

var cards : Array[Card] = []
var color_tween: Tween
@export var bar_visible: bool = false
@export var bar_text: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not bar_visible:
		%Bar.modulate = Color.TRANSPARENT
	%Bar/Label.text = bar_text
	_on_resized()
	


func _on_resized():
	var s = get_container_scale()
	custom_minimum_size.x = s.x * (534.0 * max(1.0, len(cards)))
	%VContainer.scale = s


func get_container_scale() -> Vector2:
	return Vector2(size.y/890.0, size.y/890.0)


func add_card(card: Card):
	#card.size_flags_horizontal = Control.SIZE_FILL
	card.custom_minimum_size.x = 534
	card.scale_mode = Card.ScaleMode.None
	%HContainer.add_child(card)
	cards.push_back(card)


func toggle_bar_visibility(toggle: bool = not bar_visible):
	if toggle == true:
		show_bar_fading()
	else:
		hide_bar_fading()


func show_bar_fading():
	bar_visible = true
	if color_tween != null:
		color_tween.kill()
	color_tween = get_tree().create_tween()
	color_tween.tween_property(%Bar, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)


func hide_bar_fading():
	bar_visible = false
	if color_tween != null:
		color_tween.kill()
	color_tween = get_tree().create_tween()
	color_tween.tween_property(%Bar, "modulate", Color.TRANSPARENT, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	await color_tween.finished
