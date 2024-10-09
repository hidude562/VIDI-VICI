extends Node

var year = 1750
var month = 1
var day = 1

var paused = true
var timer = Timer.new()

var months = ["Random obligatory empty/pointless string Because I don't want to always do month - 1", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var daysInMonths = [300, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func getYear():
	return str(year) + " AD"

func getMonth():
	return months[month]
	
func getDate():
	return str(day)
	
func getFullYear():
	return getMonth() + " " + getDate() + ", " + getYear()
	
func _ready() -> void:
	var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
	dateDisplay.text = getFullYear()
	add_child(timer)
	timer.wait_time = 0.2
	timer.timeout.connect(_on_timer_timeout)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("time"):
		if paused:
			paused = false
			timer.start(0)
			print("Unpaused")
		else:
			paused = true
			timer.stop()
			print("Paused")
			
func _process(delta: float) -> void:
	var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
	dateDisplay.text = getFullYear()
	
func _on_timer_timeout():
	#leap years
	if getMonth() == "February":
		if year % 4 == 0 and day == 28:
			day = 29
		else:
			if day < daysInMonths[month]:
				day += 1
			else:
				month += 1
				day = 1
	elif day < daysInMonths[month]:
		day += 1
	else:
		month += 1
		day = 1
	
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
