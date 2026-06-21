extends Node
class_name StatsManager

@export var base_data: CharacterStats

var current_level: int = 1
var current_xp: int = 0
var equipped_items: Array[ItemStats] = []

func sum_item_bonus(property_name: String) -> float:
	var total = 0.0
	for item in equipped_items:
		if property_name in item:
			var value = item.get(property_name)
			if value != null:
				total+=value
	return total

func get_total_strength() -> int:
	return base_data.strength + int(sum_item_bonus("strength")) + (current_level-1)* base_data.strength_gain
func get_total_intellect() -> int:
	return base_data.intellect + int(sum_item_bonus("intellect")) + (current_level-1)*base_data.intellect_gain
func get_total_agility() -> int:
	return base_data.agility + int(sum_item_bonus("agility")) + (current_level-1)*base_data.agility_gain
func get_total_movement_speed() -> int:
	return base_data.movement_speed + int(sum_item_bonus("movement_speed")) + get_total_agility()*2
	
func get_total_max_health() -> int:
	return base_data.max_health + int(sum_item_bonus("health")) + (current_level-1) * base_data.max_health_gain
func get_total_armor()-> int:
	return base_data.armor + int(sum_item_bonus("armor"))
func get_total_resistance()-> int:
	return base_data.resistance + int(sum_item_bonus("resistance"))	

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
	

func get_total_attack_damage() -> int:
	var base = base_data.attack_damage
	var scaling = max(get_total_strength()*0.5, get_total_agility()*0.3)
	var item_bonus = sum_item_bonus("attack_damage")
	var result = base + scaling + item_bonus
	return int(result)
func get_total_magic_damage() -> int:
	var base = base_data.magic_damage
	var scaling = get_total_intellect()
	var item_bonus = sum_item_bonus("magic_damage")
	var result = base + scaling + item_bonus
	return int(result)
func get_total_attack_speed() -> float:
	var base = base_data.attack_speed
	var scaling = get_total_agility()*0.01
	var item_bonus = sum_item_bonus("attack_speed")
	var result = base + scaling + item_bonus
	return result
func get_total_crit_chance() -> float:
	return base_data.crit_chance + sum_item_bonus("crit_chance")
func get_total_life_steal() -> int:
	return base_data.lifesteal + int(sum_item_bonus("life_steal"))
func get_total_armor_penetration() -> int:
	return base_data.armor_penetration + int(sum_item_bonus("armor_penetration"))
func get_total_resistance_penetration() -> int:
	return base_data.resistance_penetration + int(sum_item_bonus("resistance_penetration"))
func get_total_physical_crit_multiplier() -> float:
	var base = base_data.physical_crit_multiplier
	var scaling = max(get_total_strength()*0.01, get_total_agility()*0.005)
	var item_bonus = sum_item_bonus("physcial_crit_multiplier")
	var result = base + scaling + item_bonus
	return result
func get_total_magic_crit_multiplier() -> float:
	var base = base_data.magic_crit_multiplier
	var scaling = get_total_intellect()*0.02
	var item_bonus = sum_item_bonus("magic_crit_multiplier")
	var result = base + scaling + item_bonus
	return result

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
