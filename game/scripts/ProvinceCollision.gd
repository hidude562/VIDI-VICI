extends StaticBody3D

const highlightMaterial = preload("res://materials/selection.tres")
var originalMaterial: Material
var mouseInside = false
var isHighlighted = false

func highlight():
	if(not isHighlighted):
		var parentMesh = get_parent().get_mesh()
		originalMaterial = parentMesh.surface_get_material(0)
		parentMesh.surface_set_material(0, highlightMaterial)
	isHighlighted = true

func unhighlight():
	if(isHighlighted):
		var parentMesh = get_parent().get_mesh()
		if originalMaterial:
			parentMesh.surface_set_material(0, originalMaterial)
	isHighlighted = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mouseInside && isHighlighted == false:
			highlight()
		else:
			unhighlight()

func _mouse_enter() -> void:
	mouseInside = true

func _mouse_exit() -> void:
	mouseInside = false
