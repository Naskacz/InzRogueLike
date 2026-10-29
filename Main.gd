extends Node2D

@export var room_scene: PackedScene
@export var player_scene: PackedScene
@export var number_of_rooms: int = 8
@export var room_size: Vector2 = Vector2(640, 360)
var game_ready: bool = false
func _ready() -> void:
	generate_dungeon()

func generate_dungeon() -> void:
	var room_positions: Array[Vector2i] = []
	var current_grid_pos = Vector2i(0, 0)
	room_positions.append(current_grid_pos)
	
	while room_positions.size() < number_of_rooms:
		var random_room = room_positions[randi() % room_positions.size()]
		var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
		var random_dir = directions[randi() % directions.size()]
		var next_grid_pos = random_room + random_dir
		
		if not room_positions.has(next_grid_pos):
			room_positions.append(next_grid_pos)
			
	for i in range(room_positions.size()):
		var grid_pos = room_positions[i]
		var new_room = room_scene.instantiate()
		
		new_room.position = Vector2(grid_pos.x * room_size.x, grid_pos.y * room_size.y)
		add_child(new_room)
		new_room.name = "Room_" + str(grid_pos.x) + "_" + str(grid_pos.y)
		
	if player_scene != null:
		var player = player_scene.instantiate()
		var start_center = Vector2(0, 0) + (room_size / 2)
		
		player.position = start_center
		add_child(player)
		
		var camera = $Camera2D
		if camera:
			camera.global_position = start_center
	
	await get_tree().physics_frame
	game_ready = true
