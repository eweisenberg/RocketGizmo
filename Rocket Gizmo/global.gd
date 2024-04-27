extends Control

var global_mass: int
var global_fuel_mass: int
var global_engines: int
var global_height: int
var global_diameter: int
var global_nose: int
var global_material: int
var global_planet: String
var global_goal: String

var sec_played: float = 0.0

@onready var time_label: Label = $TimeLabel
@onready var tabs: TabContainer = $MarginContainer/HBoxContainer/TabContainer
@onready var black_bg: TextureRect = $MarginContainer/HBoxContainer/VisualContainer/Design/BlackTexture
@onready var rocket: Node2D = $MarginContainer/HBoxContainer/VisualContainer/Design/Rocket
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var launch_planet_texture: TextureRect = $MarginContainer/HBoxContainer/VisualContainer/Design/BlackTexture/LaunchPlanet
@onready var goal_planet_texture: TextureRect = $MarginContainer/HBoxContainer/VisualContainer/Design/BlackTexture/GoalPlanet
@onready var not_enough_thrust_label: Label = $MarginContainer/HBoxContainer/VisualContainer/Design/BlackTexture/Label

func _ready() -> void:
	_on_button_restart_pressed()

func _process(delta: float) -> void:
	sec_played += delta
	if fmod(sec_played, 60.0) < 10:
		time_label.text = "Time played: " + str(int(sec_played) / 60) + ":0" + str(int(sec_played) % 60)
	else:
		time_label.text = "Time played: " + str(int(sec_played) / 60) + ":" + str(int(sec_played) % 60)


func _on_button_play_pressed() -> void:
	black_bg.visible = true
	
	if global_planet == "Mars":
		launch_planet_texture.texture = load("res://ui/mars.png")
	elif global_planet == "Moon":
		launch_planet_texture.texture = load("res://ui/moon.png")
	else:
		launch_planet_texture.texture = load("res://ui/earth.png")
	
	if global_goal == "Mars":
		goal_planet_texture.texture = load("res://ui/mars.png")
	elif global_goal == "Moon":
		goal_planet_texture.texture = load("res://ui/moon.png")
	else:
		goal_planet_texture.texture = load("res://ui/earth.png")
	
	var thrust: float = (global_engines * 4000000) / (9.07 * global_fuel_mass / 907 * 9.81)
	var animation_speed: float = 1.0
	if thrust >= 5:
		not_enough_thrust_label.hide()
		animation_speed = 1.0 + (thrust - 5.0) * 0.1
	else:
		not_enough_thrust_label.show()
		animation_speed = 0.0
	animation_player.play("rocket_launch", -1, animation_speed)

func _on_button_restart_pressed() -> void:
	black_bg.visible = false
	animation_player.stop()
	rocket.position = Vector2(288, 580)
	rocket.scale = Vector2(1, 1)


func _on_form_button_pressed() -> void:
	OS.shell_open("https://forms.gle/1c113o8DWpJRwbFx9")


func _on_tab_container_tab_changed(tab: int) -> void:
	if is_node_ready():
		_on_button_restart_pressed()
