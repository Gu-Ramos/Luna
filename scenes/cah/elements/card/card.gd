#TODO: "carta preta", cartas customizáveis, brasil comunista, felps anão, Kibe, cartas LGBT, sw
class_name Card
extends AspectRatioContainer

signal toggled(toggled_on : bool, node : Card)
signal finished
const characters : String = "!@#$%*()_+=-£¢¬[{/\\|;:?><,.^~\"'" # 31

@export_enum("Black", "White") var type : int = 0 # 0: Black, 1: White
@export_multiline var text : String = ""
@export var pick : int = 0
@export var is_clickable : bool = false
@export var is_toggled : bool = false
@export var animation_speed : float = 0.25
@export var target_scale : float = 1.10


var main_texture : CompressedTexture2D
var scale_tween : Tween

#region Base functions
func _ready(): 
	await %Base.resized
	%Control.scale = get_card_scale()
	if is_clickable and is_toggled:
		%Image.scale = Vector2(target_scale, target_scale)
	update_card(type, text)
	finished.emit()

func _on_resized():
	if is_clickable and is_toggled:
		%Image.scale = Vector2(target_scale, target_scale)
	%Control.scale = get_card_scale()
	update_card(type, text)

func _process(_delta):
	if text == "<glitch_text>":
		var s = ""
		for i in range(1, randi_range(12,22)):
			s = s + characters[randi_range(0,30)]
		%Label.text = s

func _on_mouse_entered():
	if (not is_clickable) or is_toggled: return
	scale_up()

func _on_mouse_exited():
	if (not is_clickable) or is_toggled: return
	scale_down()

func _on_gui_input(event):
	if not is_clickable: return
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false:
		is_toggled = not is_toggled
		toggled.emit(is_toggled, self)
		if is_toggled:
			scale_up()
		else:
			scale_down()
#endregion


#region Auxiliary
func scale_up() -> void:
	var duration = animation_speed * ( (((%Image.scale.x - 1) /  (target_scale - 1)) - 1) * -1)
	if scale_tween != null: scale_tween.kill()
	scale_tween = get_tree().create_tween()
	scale_tween.tween_property(%Image, "scale", Vector2(target_scale,target_scale), duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
func scale_down() -> void:
	var duration = animation_speed * ((%Image.scale.x - 1) /  (target_scale - 1))
	if scale_tween != null: scale_tween.kill()
	scale_tween = get_tree().create_tween()
	scale_tween.tween_property(%Image, "scale", Vector2(1,1), duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func get_card_scale() -> Vector2:
	if size.y/size.x <= 812.0/534.0: # this fixes 3 cards in choose_black
		return Vector2(size.y/812, size.y/812)
	else:
		return Vector2(size.x/534, size.x/534)

func update_card(card_type : int, card_text : String) -> void:
	type = card_type
	text = card_text
	
	var target_text: String
	match card_text:
		"<A>":
			target_text = "\n"
			main_texture = Global.CARD_TEXTURES[4]
		"O tamanho dessa carta.":
			target_text = "O tamanho dessa carta."
			main_texture = Global.CARD_TEXTURES[5]
		"<Bolsonaro>":
			target_text = "\n"
			main_texture = Global.CARD_TEXTURES[6]
		"<Brasil>":
			target_text = "\n"
			main_texture = Global.CARD_TEXTURES[7]
		"<Felps_bombado>":
			target_text = "\n"
			main_texture = Global.CARD_TEXTURES[8]
		"As abelhas chegaram.":
			target_text = "\n"
			main_texture = Global.CARD_TEXTURES[9]
		"<Pau>":
			target_text = "\n"
			main_texture = Global.CARD_TEXTURES[10]
		_:
			target_text = card_text
			main_texture = Global.CARD_TEXTURES[card_type]
	
	%Label.text = target_text.replace("_", "____")
	%Image.texture = main_texture
	%Label.add_theme_color_override("default_color", Color.BLACK if type == 1 else Color.WHITE)

func get_text_size() -> float:
	return %Label.get_content_height() * get_card_scale().y

func toggle(state:bool=not is_toggled):
	is_toggled = state
	if is_toggled: scale_up()
	else: scale_down()
#endregion
