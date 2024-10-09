extends Node
			
class Nation:
	var provinces
	var name
	var color
	
	func _init():
		self.provinces = []
		self.name = "A test"
		self.color = Color.from_hsv(randf_range(0,3.14), randf_range(1,3.14), randf_range(1,3.14))
	
	func claimProvince(province: MeshInstance3D):
		province.setNation(self)
		provinces.append(province)
		print("CLAIM")
	
	func getProvinces():
		return provinces
