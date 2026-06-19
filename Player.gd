extends CharacterBody2D

@export var speed := 200

func _physics_process(delta):
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# ruch
	if dir.length() > 0:
		velocity = dir.normalized()
		move_and_slide()
		_update_animation(dir)
	else:
		$AnimatedSprite2D.play("idle")


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
