extends Resource
class_name ItemStats


@export var name: String = ""
@export var profession: Enums.Profession = Enums.Profession.ANY
@export var health: int = 0
@export var strength: int = 0
@export var intellect: int = 0
@export var agility: int = 0
@export var attack_speed: float = 0.0
@export var crit_chance: float = 0.00
@export var physical_crit_multiplier: float = 0.0
@export var magic_crit_multiplier: float = 0.0
@export var life_steal: int = 0
@export var required_level: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
