extends Node
class_name HealthComponent

signal health_changed(current_health, max_health)
signal died

var max_health: int
var current_health: int

func setup(max_hp: int):
	max_health = max_hp
	current_health = max_hp
	health_changed.emit(current_health, max_health)

func take_damage(amount: int):
	current_health -= amount
	print("Otrzymano obrażenia: ", amount, " Pozostało HP: ", current_health)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		died.emit()
