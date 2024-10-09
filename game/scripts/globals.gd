extends Node

var year = 1750
var month = 1
var day = 1

func getYear():
	return str(year) + " AD"

func getMonth():
	match month:
		1:
			return "January"
		2:
			return "February"
		3:
			return "March"
		4:
			return "April"
		5:
			return "May"
		6:
			return "June"
		7:
			return "July"
		8:
			return "August"
		9:
			return "September"
		10:
			return "October"
		11:
			return "November"
		12:
			return "December"
func getDate():
	return str(day)
	
func getFullYear():
	return getMonth() + " " + getDate() + ", " + getYear()
	
func _ready() -> void:
	var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
	dateDisplay.text = getFullYear()

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
