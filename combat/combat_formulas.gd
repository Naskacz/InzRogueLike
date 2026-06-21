class_name CombatFormulas

static func calculate_damage(attacker: StatsManager, defender: StatsManager, category: Enums.DamageCategory) -> Dictionary:
	match category:
		Enums.DamageCategory.PHYSICAL:
			return _calculate_physical(attacker,defender)
		Enums.DamageCategory.MAGIC:
			return _calculate_magic(attacker,defender)
		Enums.DamageCategory.HYBRID:
			return _calculate_hybrid(attacker,defender)
		_:
			return {"amount": 0, "is_crit": false, "type": "none"}



static func _calculate_physical(attacker: StatsManager, defender: StatsManager) -> Dictionary:
	var dmg = attacker.get_total_attack_damage()
	var is_crit = randf() <= attacker.get_total_crit_chance()
	if is_crit:
		dmg *= attacker.get_total_physical_crit_multiplier()
	var defender_armor = defender.get_total_armor()
	var armor_penetration = attacker.get_total_armor_penetration()
	
	var effective_armor = max(0, defender_armor - armor_penetration)
	var final_dmg = dmg - effective_armor
	
	return {
		"amount":int(final_dmg),
		"is_crit": is_crit,
		"type":"physical"
	}
static func _calculate_magic(attacker: StatsManager, defender: StatsManager) -> Dictionary:
	var dmg = attacker.get_total_magic_damage()
	var is_crit = randf() <= attacker.get_total_crit_chance()
	if is_crit:
		dmg *= attacker.get_total_magic_crit_multiplier()
	var defender_resistance = defender.get_total_resistance()
	var resistance_penetration = attacker.get_total_resistance_penetration()
	
	var effective_resistance = max(0, defender_resistance - resistance_penetration)
	var final_dmg = dmg - effective_resistance
	
	return {
		"amount":int(final_dmg),
		"is_crit": is_crit,
		"type":"magic"
	}
static func _calculate_hybrid(attacker: StatsManager, defender: StatsManager) -> Dictionary:
	var phys_result = _calculate_physical(attacker, defender)
	
	var mag_result = _calculate_magic(attacker, defender)
	
	return {
		"amount": phys_result.amount + mag_result.amount,
		"is_crit_physical": phys_result.is_crit,
		"is_crit_magic": mag_result.is_crit,
		"type": "hybrid",
		"breakdown": {
			"physical": phys_result.amount,
			"magic": mag_result.amount
		}
	}
