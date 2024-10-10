extends Node

const provinceScript = preload("res://scripts/Game Mechanics/Map/Province.gd")
const provinceCollisionScript = preload("res://scripts/Game Mechanics/Map/ProvinceCollision.gd")
const provinceAreaScript = preload("res://scripts/Game Mechanics/Map/provinceNeighborsInitializer.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if(child.get_class() == "MeshInstance3D"):
			var area3d = Area3D.new()
			area3d.set_script(provinceAreaScript)
			area3d.set_physics_process(true)
			
			child.create_multiple_convex_collisions()
			var extractedCollision = child.get_child(0).get_child(0)
			child.get_child(0).queue_free()
			
			area3d.monitorable = true
			area3d.monitoring = true
			
			var collisionDuplicate = extractedCollision.duplicate()
			area3d.add_child(collisionDuplicate)
			child.add_child(area3d)
			
			child.set_script(provinceScript)
			child.set_process(true)
			
			child.create_trimesh_collision()
			var staticBodyChild = child.get_child(2)
			staticBodyChild.set_script(provinceCollisionScript)
			staticBodyChild.set_process_input(true)
			
			var collisionChild = staticBodyChild.get_child(0)
