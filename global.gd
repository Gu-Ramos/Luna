extends Node

var CARDS : Dictionary
var CARD_TEXTURES : Array[CompressedTexture2D] = [
	load("res://content/assets/cards/black_front.png"),   # 0
	load("res://content/assets/cards/white_front.png"),   # 1
	load("res://content/assets/cards/black_back.png"),    # 2
	load("res://content/assets/cards/white_back.png"),    # 3
	load("res://content/assets/cards/A.png"),             # 4
	load("res://content/assets/cards/big.png"),           # 5
	load("res://content/assets/cards/bolsonaro.png"),     # 6
	load("res://content/assets/cards/brasil.png"),        # 7
	load("res://content/assets/cards/felps_bombado.png"), # 8
	load("res://content/assets/cards/blood.png"),         # 9
	load("res://content/assets/cards/pau.png"),           # 10
]
var SCREENS : Array[PackedScene] = [
	load("res://scenes/game_ui/menu/menu.tscn"),          # 0
	load("res://scenes/game_ui/host_menu/host_menu.tscn"), # 1
	load("res://scenes/game_ui/join_menu/join_menu.tscn")  # 2
]
var ELEMENTS : Array[PackedScene] = [
	preload("res://scenes/cah/elements/card/card.tscn"),                                      # 0
	preload("res://scenes/cah/elements/vertical_card_container/vertical_card_container.tscn") # 1
]
var CONFIGS : Dictionary = {
	global = {
		join = true,
		nickname = "",
		ip = ""
	},
	CCH = {
		black_number = 2,
		voting = {
			enabled = false,
			mode = 0 # 0: normal | 1: no abstaining
		},
		custom_white = {
			enabled = false,
			mode = 0, # 0: permanent | 1: periodic | 2: random
			delay = 3,
			optional = false
		},
		custom_black = {
			enabled = false,
			mode = 0, # 0: permanent | 1: periodic | 2: random
			delay = 3,
			optional = false,
			collective = true
		}
	}
}
var GAME : Dictionary = {
	current_role = "judge",
	current_screen = "choose_black",
	black_cards = [
		{
			text = "Carta 1 _.",
			pick = 1
		},
		{
			text = "Carta 2 _.",
			pick = 1
		},
		#{
			#text = "Carta 3 _.",
			#pick = 1
		#}
	],
	white_cards = [ # cada array é um grupo de cartas, podendo ser ou as "respostas" de cada jogador, ou a resposta vencedora, etc.
		[
			"O tamanho dessa carta.",
			"Um Boeing 747 caindo de cauda na tua frente depois de uma colisão com um urubu.",
			"1m³ de tungstênio."
		],
	],
	player_cards = [],
	player_list = [],
	extra_info = {
		winners = ["Jôncio"]
	}
}

func _ready():
	var file = FileAccess.open("res://content/cards.json", FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK :
		CARDS = json.data
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", "json_string", " at line ", json.get_error_line())
	
	print("Cartas pretas: ", len(CARDS.blackCards))
	print("Cartas brancas: ", len(CARDS.whiteCards))
	print("Total de cartas: ", len(CARDS.whiteCards) + len(CARDS.blackCards))
