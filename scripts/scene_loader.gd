extends Node

var level_instance: Node

## Functions
func load_level(level_name: String) -> void:
	unload_level()

	var level_path := "res://scenes/%s/%s.tscn" % [level_name, level_name]
	var level_resource := load(level_path)
	if (!level_resource):
		return
	
	get_tree().change_scene_to_file(level_path)

func unload_level() -> void:
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	
	level_instance = null
