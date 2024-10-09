extends Node

var nations = []

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
	for i in range(75):
		var newNation = Globals.Nation.new()
		var centerProvince = getRandomUnclaimedProvince()
		newNation.claimProvince(centerProvince)
		nations.append(newNation)

var frame = 0

func _process(delta: float) -> void:
	if frame % 100 == 0:
		for nation in nations:
			claimNeighbors(nation, nation.getProvinces(), 1)
	frame+=1

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
		randomProvince = getRandomLandProvince()
	return randomProvince
