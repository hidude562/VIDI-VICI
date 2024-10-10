extends Node

class Nation extends Node:
	var provinces
	var color
	var label
	var isPlayerNation
	
	var potentialNations = ["Denmark", "Great Britain", "Ireland", "France", "Prussia", "Netherlands", "Sweden", "Egypt", "Two Sicilies", "Austria", "Hungary", "Romania", "Greece", "Austria", "Switzerland", "Belgium", "Luxembourg", "Poland", "Russia", "Turkey", "Spain", "Portugal"]
	var nationID = RandomNumberGenerator.new().randi_range(0, len(potentialNations) - 1)

	func _init(isPlayerNation: bool):
		self.isPlayerNation = isPlayerNation
		self.provinces = []
		#give the nation a random name from one out of the array of european countries
		self.name = potentialNations[nationID]
		potentialNations.remove_at(nationID)
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

class Culture extends Node:
	var cultureName
	var population
	#the racism variable is more a "cultures this culture hates" variable
	var racism = []
	var religion
	
	var potentialReligions = ["Christianity", "Buddhism", "Hinduism", "Sikhism", "Islam", "Judaism"]
	
	func randomlyDetermineReligion():
		var religionID = RandomNumberGenerator.new().randi_range(0, len(potentialReligions - 1))
		religion = potentialReligions[religionID]
		#determine racism based off religions
		match religionID:
			0:
				for i in range(1, 4):
					racism.append(potentialReligions[i])
			2:
				racism.append(potentialReligions[1])
				racism.append(potentialReligions[3])
				racism.append(potentialReligions[4])
				racism.append(potentialReligions[5])
			4:
				for i in range(0, 3):
					racism.append(potentialReligions[i])
				racism.append(potentialReligions[5])
	
	func _init(_name: String, _population: int, _religion: String):
		cultureName = _name
		population = _population
		religion = _religion
