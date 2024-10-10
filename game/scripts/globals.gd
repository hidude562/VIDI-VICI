extends Node

class Nation extends Node:
	var provinces
	var color
	var label
	var isPlayerNation

	func _init(isPlayerNation: bool):
		self.isPlayerNation = isPlayerNation
		self.provinces = []
		self.name = "A test nation"
		if(self.isPlayerNation):
			self.name += " (You)"
		self.color = Color.from_hsv(randf_range(0,3.14), randf_range(1,3.14), randf_range(1,3.14))
		self.label = Label3D.new()
		self.label.text = self.name
		self.label.scale *= 0.2
		get_node("./").add_child(self.label)
	func claimProvince(province: MeshInstance3D):
		province.setNation(self)
		provinces.append(province)
		putLabel()
		print("CLAIM")

	func putLabel():
		self.label.position = self.provinces[0].getCenter()
		self.label.rotation.x = -PI/2
		self.label.global_position.y += 0.01
		
	func getProvinces():
		return provinces
