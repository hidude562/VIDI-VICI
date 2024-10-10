extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func display(province):
	var prefixEnemy = "./Enemy Province/"
	var prefixPlayer = "./Player Province/"
	var prefix = ""
	
	get_node(prefixEnemy).hide()
	get_node(prefixPlayer).hide()
	
	if(province.nation!=null and province.nation.getIsPlayerNation()):
		prefix = prefixPlayer
		get_node(prefixPlayer).show()
	else:
		prefix = prefixEnemy
		get_node(prefixEnemy).show()
	
	var labelName = get_node(prefix+"Main/VBoxContainer/Name/Name")
	var labelPopulation = get_node(prefix+"Main/VBoxContainer/Population/Name")
	var labelGdp = get_node(prefix+"Main/VBoxContainer/MoreInfo/GDP/Name")
	var labelScience = get_node(prefix+"Main/VBoxContainer/MoreInfo/Science/Name")
	
	labelName.text = province.get_name()
	labelPopulation.text = "Population: " + str(Globals.number_format(province.population))
	labelGdp.text = "GDP: $" + str(Globals.number_format(province.getGDP()))
	labelScience = "Science: " + str(Globals.number_format(province.getScience()))
	
	if(prefix == prefixEnemy):
		var ownerNation = get_node(prefix+"Main/VBoxContainer/Graphs/VBoxContainer/Graphs/Owner/VBoxContainer/Nation")
		var control = get_node(prefix+"Main/VBoxContainer/Graphs/VBoxContainer/Graphs/Owner/VBoxContainer/HBoxContainer/VBoxContainer2/Control")
		
		ownerNation.text = "Owner: "
		if(province.nation == null):
			ownerNation.text += "Unclaimed province"
		else:
			ownerNation.text += province.nation.getNationName()
		
		control.text = "Control: " + str(province.getControl())
