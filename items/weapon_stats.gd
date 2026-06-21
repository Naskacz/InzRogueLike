extends ItemStats
class_name WeaponStats

@export var damage_category: Enums.DamageCategory
@export var attack_damage: int = 0
@export var magic_damage: int = 0
@export var armor_penetration: int = 0
@export var resistance_penetration: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
