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
	
func dateChangeThing():
	if day < daysInMonths[month]:
		day += 1
	else:
		month += 1
		day = 1	
	
func _on_timer_timeout():
	#leap years
	if getMonth() == "February":
		if (year % 4 == 0 and day == 28) and (not year % 100 == 0 or year % 400 == 0):
			day = 29
		else:
			dateChangeThing()
	else:
		dateChangeThing()
