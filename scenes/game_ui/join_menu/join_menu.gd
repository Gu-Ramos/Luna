extends GameScreen


func _on_nickname_text_changed(new_text):
	Global.CONFIGS.global.nickname = new_text


func _on_ip_text_changed(new_text):
	Global.CONFIGS.global.ip = new_text


func _on_join_pressed():
	pass #TODO: join_pressed


func _on_back_pressed():
	#TODO: disable_interactive()
	slide_right(true)
	emit_signal("change_scene", Global.SCREENS[0], 1)
