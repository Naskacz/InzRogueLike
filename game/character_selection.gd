extends Control

@export var warrior_stats: CharacterStats
@export var mage_stats: CharacterStats
@export var hunter_stats: CharacterStats

func _on_warrior_button_pressed():
	_start_game(warrior_stats)
func _on_mage_button_pressed():
	_start_game(mage_stats)
func _on_hunter_button_pressed():
	_start_game(hunter_stats)
	
func _start_game(stats: CharacterStats):
	GameManager.selected_stats = stats
	get_tree().change_scene_to_file("res://Main.tscn")
