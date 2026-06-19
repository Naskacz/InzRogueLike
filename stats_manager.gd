extends Node
class_name StatsManager

@export var base_data: CharacterStats

var current_level: int = 1
var current_xp: int = 0
var equipped_items: Array[ItemStats] = []

func sum_item_bonus(property_name: String) -> float:
	var total = 0.0
	for item in equipped_items:
		total+=item.get(property_name)
	return total


func get_total_strength() -> int:
	return base_data.max_health + int(sum_item_bonus("strength")) + (current_level-1)* base_data.strength_gain
func get_total_intellect() -> int:
	return base_data.max_health + int(sum_item_bonus("intellect")) + (current_level-1)*base_data.intellect_gain
func get_total_agility() -> int:
	return base_data.max_health + int(sum_item_bonus("agility")) + (current_level-1)*base_data.agility_gain
func get_total_movement_speed() -> int:
	return base_data.movement_speed + int(sum_item_bonus("movement_speed")) + get_total_agility()*2
	
func get_total_max_health() -> int:
	return base_data.max_health + int(sum_item_bonus("health")) + (current_level-1) * base_data.max_health_gain
func get_total_armor()-> int:
	return base_data.armor + int(sum_item_bonus("armor"))
	
func get_total_xp_multiplier() -> float:
	return base_data.xp_multiplier + sum_item_bonus("xp_multiplier") + get_total_intellect()*0.2
	
func add_xp(amount: int):
	current_xp += ceil(amount*get_total_xp_multiplier())
	while current_xp >= get_required_xp():
		current_xp -= get_required_xp()
		level_up()
func get_required_xp() -> int:
	return current_level * 100
func level_up():
	current_level += 1
	
# TODO COMBAT STATS, ADD INHERITED ITEM CLASSES 
#func get_total_attack_damage() -> int:
	#return 
	
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
