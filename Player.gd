extends CharacterBody2D

@onready var stats_manager = $StatsManager


func _physics_process(_delta):
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if dir.length() > 0:
		var current_speed = stats_manager.get_total_movement_speed()
		
		velocity = dir.normalized() * current_speed
		move_and_slide()
		_update_animation(dir)
	else:
		$AnimatedSprite2D.play("idle")
		velocity = Vector2.ZERO 


func _update_animation(dir: Vector2):
	if dir.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif dir.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif dir.y < 0:
		$AnimatedSprite2D.play("walk_up")
	elif dir.y > 0:
		$AnimatedSprite2D.play("walk_down")
	else:
		$AnimatedSprite2D.play("idle")
