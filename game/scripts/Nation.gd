extends Node3D

var provinces
var color
var label

func _init():
	self.provinces = []
	self.name = "A test"
	self.color = Color.from_hsv(randf_range(0,3.14), randf_range(1,3.14), randf_range(1,3.14))
	self.label = Label3D.new()
	self.label.text = self.name
	if get_node_or_null("/root/Game") != null:
		get_node("/root/Game").add_child(self.label)
func claimProvince(province: MeshInstance3D):
	province.setNation(self)
	provinces.append(province)
	print("CLAIM")

func putLabel():
	self.label.global_position = self.provinces[0].global_position
	
func getProvinces():
	return provinces
