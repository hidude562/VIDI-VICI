extends Node

func _ready() -> void:
	if get_node("/root/Game/Control/Top display/ColorRect/Label") != null:
		var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
		dateDisplay.text = TimeManager.getFullYear()
		add_child(TimeManager.timer)
		TimeManager.timer.wait_time = 1
		TimeManager.timer.timeout.connect(TimeManager._on_timer_timeout)

func _process(delta: float) -> void:
	if get_node("/root/Game/Control/Top display/ColorRect/Label") != null:
		var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
		dateDisplay.text = TimeManager.getDayOfWeek() + " " + TimeManager.getFullYear()
