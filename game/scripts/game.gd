extends Node

var nations = []
var provinces = []
@onready var map = get_node("Europe map/")

func claimNeighbors(nation, provinces, num: int):
	var claimed = 0
	for province in provinces:
		var neighbors = province.getNeighbors()
		for prov in neighbors:
			if(prov.isClaimable()):
				nation.claimProvince(prov)
				claimed+=1
				claimed+=claimNeighbors(nation, [prov], num-claimed)
			if(claimed>=num):
				break
	return claimed

func _ready():
	for i in range(50):
		var newNation = Nation.new()
		var centerProvince = getRandomUnclaimedProvince()
		newNation.claimProvince(centerProvince)
		nations.append(newNation)

var frame = 0

func _process(delta: float) -> void:
	if frame % 100 == 0:
		for nation in nations:
			claimNeighbors(nation, nation.getProvinces(), 1)
			nation.putLabel()
	frame+=1

func getRandomProvince():
	return map.get_child(randi_range(1, map.get_child_count()-1))

func getRandomLandProvince():
	var randomProvince = getRandomProvince()
	while randomProvince.isWater():
		randomProvince = getRandomProvince()
	return randomProvince

func getAllProvinces():
	if provinces == []:
		provinces = []
		for i in map.get_children():
			if(i is MeshInstance3D):
				provinces.append(i)
		return provinces
	else:
		return provinces

func getRandomUnclaimedProvince():
	var randomProvince = getRandomLandProvince()
	while randomProvince.getNation() != null:
		randomProvince = getRandomLandProvince()
	return randomProvince

func nextDay():
	print("Next day")
	var provinces = getAllProvinces()
	for i in provinces:
		i.nextDay()
