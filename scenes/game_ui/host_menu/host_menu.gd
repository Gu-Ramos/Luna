extends GameScreen

func _ready():
	%AskJoin.set_toggled(Global.CONFIGS.global.join)
	%Voting.set_toggled(Global.CONFIGS.CCH.voting.enabled)
	%CustomWhite.set_toggled(Global.CONFIGS.CCH.custom_white.enabled)
	%CustomBlack.set_toggled(Global.CONFIGS.CCH.custom_black.enabled)
	%Nickname.visible = %AskJoin.is_toggled
	%Nickname.text = Global.CONFIGS.global.nickname
	%SliderContainer/Label.text = "Número de cartas pretas: " + str(Global.CONFIGS.CCH.black_number)

func _on_back_pressed():
	#TODO: disable_interactive()
	slide_right(true)
	change_scene.emit(Global.SCREENS[0], 1)


func _on_ask_join_pressed():
	%Nickname.visible = %AskJoin.is_toggled
	Global.CONFIGS.global.join = %AskJoin.is_toggled


func _on_voting_pressed():
	Global.CONFIGS.CCH.voting.enabled = %Voting.is_toggled


func _on_custom_white_pressed():
	Global.CONFIGS.CCH.custom_white.enabled = %CustomWhite.is_toggled


func _on_custom_black_pressed():
	Global.CONFIGS.CCH.custom_black.enabled = %CustomBlack.is_toggled


func _on_nickname_text_changed(new_text):
	Global.CONFIGS.global.nickname = new_text


func _on_cards_number_hard_value_changed(value):
	Global.CONFIGS.CCH.blackNumber = value
	%SliderContainer/Label.text = "Número de cartas pretas: " + str(value)
