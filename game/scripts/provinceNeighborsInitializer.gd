extends Area3D

func _process(delta: float) -> void:
	print(get_overlapping_areas())
	for area in get_overlapping_areas():
		get_parent().addNeighbor(area.get_parent())
		queue_free()
