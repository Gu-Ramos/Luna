extends Control


var global_scale : Vector2 = Vector2(1,1)


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	await get_tree().create_timer(0.25).timeout
	$Game/CurrentScreen.slide_down()


func _on_resized():
	#TODO: Better scaling formula
	#TODO: size.x is kinda buggy
	#TODO: Portrait mode
	if size.y < 720:
		global_scale = Vector2(1,1) * size.y/720
	elif size.y > 900:
		global_scale = Vector2(1,1) * size.y/(900)
	else:
		global_scale = Vector2(1,1)
	if size.x < 350*global_scale.x:
		global_scale = Vector2(1,1) * size.x/350
	
	if $Game.find_child("PreviousScreen", false, false) != null:
		$Game/PreviousScreen.scale = global_scale
	$Game/CurrentScreen.scale = global_scale
	$Settings.scale = global_scale
	$Settings.position = global_scale * 16
	
	%BackgroundParticles.emission_rect_extents = size/2


func change_scene(scene : PackedScene, transition : int) -> void:
	$Game/CurrentScreen.set_name("PreviousScreen")
	
	var new_scene = scene.instantiate()
	$Game.add_child(new_scene)
	new_scene.set_name("CurrentScreen")
	
	new_scene.modulate = Color.TRANSPARENT
	new_scene.scale = global_scale
	new_scene.change_scene.connect(change_scene)
	
	match transition:
		0:
			new_scene.position = Vector2(size.x,0)
			new_scene.slide_left()
		1:
			new_scene.position = Vector2(-size.x,0)
			new_scene.slide_right()
		2:
			new_scene.position = Vector2(0,-size.y)
			new_scene.slide_down()
		3:
			new_scene.position = Vector2(0,size.y)
			new_scene.slide_up()
		4:
			new_scene.position = Vector2(0,0)
			new_scene.fade()
