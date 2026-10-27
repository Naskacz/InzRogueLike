extends CharacterBody2D

func _ready():
	$HealthComponent.health_changed.connect(_on_health_changed)
	$HealthComponent.died.connect(queue_free) # Znika po śmierci
	$HealthComponent.setup($StatsManager.get_total_max_health())

func _on_health_changed(current, max_hp):
	$ProgressBar.max_value = max_hp
	$ProgressBar.value = current
