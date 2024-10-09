extends Node

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("time"):
		if TimeManager.paused:
			TimeManager.paused = false
			TimeManager.timer.start(0)
			print("Unpaused")
		else:
			TimeManager.paused = true
			TimeManager.timer.stop()
			print("Paused")
	if Input.is_action_just_pressed("speedControl1"):
		TimeManager.timer.wait_time = 1
	if Input.is_action_just_pressed("speedControl2"):
		TimeManager.timer.wait_time = 0.8
	if Input.is_action_just_pressed("speedControl3"):
		TimeManager.timer.wait_time = 0.6
	if Input.is_action_just_pressed("speedControl4"):
		TimeManager.timer.wait_time = 0.4
	if Input.is_action_just_pressed("speedControl5"):
		TimeManager.timer.wait_time = 0.2
