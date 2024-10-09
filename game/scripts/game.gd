extends Node

var nations = []

func _ready():
	for i in range(130):
		print(i)
		var newNation = Globals.Nation.new()
		newNation.claimProvince(getRandomUnclaimedProvince())
		nations.append(newNation)

func getRandomProvince():
	var map = get_node("Europe map/")
	return map.get_child(randi_range(1, map.get_child_count()-1))

func getRandomLandProvince():
	var randomProvince = getRandomProvince()
	while randomProvince.isWater():
		randomProvince = getRandomProvince()
	return randomProvince

func getRandomUnclaimedProvince():
	var randomProvince = getRandomLandProvince()
	while randomProvince.getNation() != null:
		print(randomProvince.getNation())
		print("Infinite?")
		randomProvince = getRandomLandProvince()
	return randomProvince
