extends Node

@export var next_scene : PackedScene

func go_to_next_level():
	get_tree().change_scene_to_packed(next_scene)

#####################################################

# could use preload isntead of load too, but the scenes would be loaded into ra
var scenes = {
	"Tutorial1" = load("[...]"),
	"Tutorial1andahalf" = load("[...]"),
}
func _go_to_next_level():
	var scene_name
	scene_name = get_tree().current_scene_name()
	get_tree().change_scene_to_packed(scenes[scene_name])
