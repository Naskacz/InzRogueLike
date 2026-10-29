extends Area2D

@export var direction: Vector2i = Vector2i.RIGHT

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var camera = get_viewport().get_camera_2d()
		if camera:
			var room_size = Vector2(640, 360)
			
			# Pobieramy rodzica drzwi (czyli konkretny pokój, w którym stoi gracz)
			var current_room = get_parent()
			
			# Obliczamy absolutny środek DOCELOWEGO pokoju 
			# (Pozycja obecnego pokoju + przesunięcie o jeden pokój w danym kierunku + środek pokoju)
			var target_room_center = current_room.global_position + (Vector2(direction) * room_size) + (room_size / 2)
			
			# Płynny ruch kamery
			var tween = create_tween()
			tween.tween_property(camera, "global_position", target_room_center, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			
			# Automatycznie "wpychamy" gracza w głąb nowego pokoju, 
			# żeby nie stał bezpośrednio na czujniku drzwi powrotnych
			body.global_position += Vector2(direction) * 120.0
