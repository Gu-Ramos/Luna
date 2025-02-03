class_name PulseButton
extends Button

@export var is_toggleable : bool = true
@export var is_toggled : bool = true
@export var texture_on : CompressedTexture2D
@export var texture_off : CompressedTexture2D

func _ready():
	if is_toggleable:
		$Icon.texture = texture_on if is_toggled else texture_off
	else:
		$Icon.texture = texture_on

func _pressed():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("wiggle")
	
	if is_toggleable:
		is_toggled = not is_toggled
		$Icon.texture = texture_on if is_toggled else texture_off

func set_toggled(state : bool) -> void:
	is_toggled = state
	button_pressed = is_toggled
	$Icon.texture = texture_on if is_toggled else texture_off
