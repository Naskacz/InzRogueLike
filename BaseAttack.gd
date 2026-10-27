extends Area2D

var attacker_stats: StatsManager 
var direction = Vector2.ZERO
var speed = 0.0
var damage_category = Enums.DamageCategory.PHYSICAL
var hit_targets: Array = []

func _ready() -> void:
	# Obsługa animacji i usuwania obiektu
	if has_node("AnimatedSprite2D"):
		var sprite = $AnimatedSprite2D
		sprite.play("default")
		# Atak zniknie sam, gdy skończy się jego animacja (np. błysk miecza)
		sprite.animation_finished.connect(queue_free)
	else:
		# Jeśli to atak wręcz bez animacji, usuń go po 0.2 sekundy
		if speed <= 0:
			get_tree().create_timer(0.2).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	# Jeśli to pocisk, przesuń go w świecie
	if speed > 0:
		global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	# 1. Ignoruj samego siebie (atakującego)
	if attacker_stats and body == attacker_stats.get_parent():
		return
	
	# 2. Sprawdź, czy cel ma komponent zdrowia i czy nie został już trafiony tym ciosem
	var health = body.get_node_or_null("HealthComponent")
	var target_stats = body.get_node_or_null("StatsManager")
	
	if health and target_stats and body not in hit_targets:
		hit_targets.append(body)
		
		# 3. Oblicz obrażenia przy użyciu Twoich formuł
		var result = CombatFormulas.calculate_damage(attacker_stats, target_stats, damage_category)
		
		# 4. Zadaj obrażenia
		health.take_damage(result.amount)
		
		# 5. Jeśli to pocisk (strzała/ogień), usuń go po pierwszym trafieniu
		if speed > 0:
			queue_free()
