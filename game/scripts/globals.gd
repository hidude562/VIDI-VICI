extends Node
			
class Nation:
	var provinces
	var name
	var color
	
	func _init():
		self.provinces = []
		self.name = "A test"
		self.color = Color.from_hsv(randf_range(0,3.14), 1.0, 3.0)
	func claimProvince(province: MeshInstance3D):
		province.setNation(self)
