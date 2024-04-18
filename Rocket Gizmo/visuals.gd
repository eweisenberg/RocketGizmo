extends MarginContainer

@onready var rocket_rect: Polygon2D = $Design/Polygon2D
@onready var nose_sprite: Sprite2D = $Design/Sprite2D

func _process(delta: float) -> void:
	var height: int = get_tree().root.get_child(0).global_height
	rocket_rect.scale.y = height / 80.0
	
	var diameter: int = get_tree().root.get_child(0).global_diameter
	rocket_rect.scale.x = diameter / 10.0 * 1.1
	
	var nose: int = get_tree().root.get_child(0).global_nose
	if nose == 0: # parabolic
		nose_sprite.texture = load("res://sprites/parabola_sprite.tres")
	elif nose == 1: # ogive
		nose_sprite.texture = load("res://sprites/ogive_sprite.tres")
	elif nose == 2: # cone
		nose_sprite.texture = load("res://sprites/cone_sprite.tres")
	else: # blunt
		nose_sprite.texture = Texture2D.new()
	nose_sprite.position.y = rocket_rect.position.y - rocket_rect.scale.y * 300
	nose_sprite.scale.x = diameter / 100.0 * 1.1
	
	var material: int = get_tree().root.get_child(0).global_material
	if material == 0: # aluminum
		rocket_rect.color = Color.GRAY
	elif material == 1: # titanium
		rocket_rect.color = Color.WEB_GRAY
	else: # carbon composite
		rocket_rect.color = Color.BLACK
