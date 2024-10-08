extends Node

var provinceScript = preload("res://scripts/Province.gd")
var provinceCollisionScript = preload("res://scripts/ProvinceCollision.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if(child.get_class() == "MeshInstance3D"):
			child.set_script(provinceScript)
			child.set_process(true)
			
			child.create_trimesh_collision()
			var collisionChild = child.get_child(0)
			collisionChild.set_script(provinceCollisionScript)
			collisionChild.set_process_input(true)
