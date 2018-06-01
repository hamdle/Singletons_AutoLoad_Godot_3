# global.gd
extends Node

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	goto_scene("res://scene_b.tscn")
	
func goto_scene(path):
	# Use a deferred call to make sure we
	# do not delete a scene that is running
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# Free the current scene
	current_scene.free()
	
	# Load new scene
	var s = ResourceLoader.load(path)
	
	# Instance the new scene
	current_scene = s.instance()
	
	# Add it to the active scene, as a child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, make compatibile with SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)
	