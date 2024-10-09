extends Node

func _ready() -> void:
	var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
	dateDisplay.text = TimeManager.getFullYear()
	add_child(TimeManager.timer)
	TimeManager.timer.wait_time = 1
	TimeManager.timer.timeout.connect(TimeManager._on_timer_timeout)

func _process(delta: float) -> void:
	var dateDisplay = get_node("/root/Game/Control/Top display/ColorRect/Label")
	dateDisplay.text = TimeManager.getFullYear()
