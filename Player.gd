extends CharacterBody2D

@onready var stats_manager = $StatsManager
@onready var sprite = $AnimatedSprite2D

func _ready():
	if GameManager.selected_stats:
		stats_manager.base_data = GameManager.selected_stats
	
	if stats_manager.base_data and stats_manager.base_data.character_animations:
		sprite.sprite_frames = stats_manager.base_data.character_animations
		sprite.play("idle")

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
		sprite.play("idle")
		velocity = Vector2.ZERO 

func _update_animation(dir: Vector2):
	if dir.x > 0:
		sprite.play("walk_right")
	elif dir.x < 0:
		sprite.play("walk_left")
	elif dir.y < 0:
		sprite.play("walk_up")
	elif dir.y > 0:
		sprite.play("walk_down")
	else:
		sprite.play("idle")

func _input(event):
	if event.is_action_pressed("attack") and not event.is_echo(): 
		attack()

func attack():
	var scene = stats_manager.base_data.attack_scene
	var attack_instance = scene.instantiate()
	
	# Dane pomocnicze
	var direction = (get_global_mouse_position() - global_position).normalized()
	var offset = 40 
	
	# Przekazujemy statystyki
	attack_instance.attacker_stats = self.stats_manager

	if attack_instance.speed <= 0:
		# --- WOJOWNIK (ATAK WRĘCZ) ---
		add_child(attack_instance) 
		attack_instance.position = direction * offset 
	else:
		# --- MAG / ŁOWCA (POCISK) ---
		get_parent().add_child(attack_instance) 
		attack_instance.global_position = global_position + (direction * offset)
		attack_instance.direction = direction
	
	attack_instance.rotation = direction.angle()
