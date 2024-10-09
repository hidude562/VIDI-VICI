extends Node

var year = 1750
var month = 1
var day = 1

var paused = true
var timer = Timer.new()

var months = ["Random obligatory empty/pointless string Because I don't want to always do month - 1", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var daysInMonths = [300, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

var daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

func getYear():
	return str(year) + " AD"

func getMonth():
	return months[month]
	
func getDate():
	return str(day)
	
func getFullYear():
	return getMonth() + " " + getDate() + ", " + getYear()
	
func getDayOfWeek():
	#this formula is retarded https://cs.uwaterloo.ca/~alopez-o/math-faq/node73.html
	
	var k = day
	var m = 0
	#get m because this formula stupid
	if month >= 3:
		m = month - 2
	elif month == 1:
		m = 11
	elif month == 2:
		m = 12
		
	var c = int(year / 100)
	var y = int(year % 100)
	
	var dayOfWeek = int((k + floor((2.6*m)-0.2) - (2*c) + y + floor((y/4) + floor(c/4))))%7
	return(daysOfWeek[dayOfWeek])
	
func dateChangeThing():
	if day < daysInMonths[month]:
		day += 1
	else:
		if month != 12:
			month += 1
		else:
			month = 1
			year += 1
		day = 1	
	var game = get_node_or_null("/root/Game")
	if(game != null):
		game.nextDay()
	
func _on_timer_timeout():
	#leap years
	if getMonth() == "February":
		if (year % 4 == 0 and day == 28) and (not year % 100 == 0 or year % 400 == 0):
			day = 29
		else:
			dateChangeThing()
	else:
		dateChangeThing()
