extends Resource
class_name CharacterStats

@export var profession: Enums.Profession

@export_group("Base Stats")
@export var strength: int = 1
@export var intellect: int = 1
@export var agility: int = 1
@export var movement_speed: int = 100

@export_group("Defensive Stats")
@export var max_health: int = 100
@export var armor: int = 0
@export var resistance: int = 0
@export var health_regen: int = 0

@export_group("Leveling")
@export var xp_multiplier: float = 1.0

@export_group("Growth Per Level")
@export var max_health_gain: int = 5
@export var strength_gain: int = 0
@export var intellect_gain: int = 0
@export var agility_gain: int = 0

@export_group("Combat Stats")
@export var attack_damage: int = 0
@export var magic_damage: int = 0
@export var attack_speed: float = 1
@export var crit_chance: float = 0.01
@export var lifesteal: int = 0
@export var armor_penetration: int = 0
@export var resistance_penetration: int = 0
@export var physical_crit_multiplier: float = 1.25
@export var magic_crit_multiplier: float = 1.25



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
