extends MeshInstance3D

@export var population = randi_range(3000,5000)
@export var nation = null
@onready var game = get_node("/root/Europe map")

var isBeingDisplayed = false;
var neighbors = []

func addNeighbor(neighbor: Node):
	neighbors.append(neighbor)

func getNeighbors():
	return neighbors

func getScience():
	return population / 10.0

func getGDP():
	return population * 1000

func nextDay():
	population = round(population * 1.001)
	for neighbor in neighbors:
		if isClaimed:
			var gdpRatio = getGDP() / neighbor.getGDP()
			var immigration = 0
			population += immigration
			neighbor.population -= immigration
	if isBeingDisplayed:
		updateProvinceDisplay()

func number_format(value: float) -> String:
	var abs_value = abs(value)
	var suffix = ""
	var formatted_value = value
	if abs_value >= 1_000_000_000_000:
		formatted_value = value / 1_000_000_000_000
		suffix = "T"
	elif abs_value >= 1_000_000_000:
		formatted_value = value / 1_000_000_000
		suffix = "B"
	elif abs_value >= 1_000_000:
		formatted_value = value / 1_000_000
		suffix = "M"
	elif abs_value >= 1_000:
		formatted_value = value / 1_000
		suffix = "K"
	
	return str(round(formatted_value * 100) / 100) + suffix


func updateProvinceDisplay():
	var provinceDisplay = get_node("/root/Game/" + "/Control/Province display")
	var labelName = provinceDisplay.get_node("./Main/VBoxContainer/Name/Name")
	var labelPopulation = provinceDisplay.get_node("./Main/VBoxContainer/Population/Name")
	var labelGdp = provinceDisplay.get_node("./Main/VBoxContainer/MoreInfo/GDP/Name")
	var labelScience = provinceDisplay.get_node("./Main/VBoxContainer/MoreInfo/Science/Name")
	
	labelName.text = get_name()
	labelPopulation.text = "Population: " + str(number_format(population))
	labelGdp.text = "GDP: $" + str(number_format(getGDP()))
	labelScience = "Science: " + str(number_format(getScience()))

func isWater():
	# If the color is blue, assume it is the water
	if(get_mesh().surface_get_material(0).albedo_color.b >  0.8):
		return true
	return false

func setNation(_nation: Globals.Nation):
	nation = _nation
	var material := get_mesh().surface_get_material(0).duplicate()
	material.albedo_color = _nation.color
	get_mesh().surface_set_material(0, material)

func getCenter():
	var faces = get_mesh().get_faces()
	var avgPosition = Vector3()
	for face in faces:
		avgPosition += face
	avgPosition /= len(faces)
	avgPosition *= scale
	return avgPosition

func isClaimed():
	return nation != null

func isClaimable():
	return not isClaimed() && not isWater();

func getNation():
	return nation

func showInformation():
	isBeingDisplayed = true
	updateProvinceDisplay()

func hideInformation():
	isBeingDisplayed = false
