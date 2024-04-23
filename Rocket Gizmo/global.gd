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

func _ready() -> void:
	_on_button_restart_pressed()

func _process(delta: float) -> void:
	sec_played += delta
	if sec_played < 10:
		time_label.text = "Time played: " + str(int(sec_played) / 60) + ":0" + str(int(sec_played) % 60)
	else:
		time_label.text = "Time played: " + str(int(sec_played) / 60) + ":" + str(int(sec_played) % 60)


func _on_button_play_pressed() -> void:
	set_tabs_disabled(true)
	black_bg.visible = true
	animation_player.play("rocket_launch")
	
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

func _on_button_restart_pressed() -> void:
	set_tabs_disabled(false)
	black_bg.visible = false
	animation_player.stop()
	rocket.position = Vector2(288, 580)
	rocket.scale = Vector2(1, 1)

func set_tabs_disabled(disabled: bool) -> void:
	tabs.set_tab_disabled(0, disabled)
	tabs.set_tab_disabled(1, disabled)
	tabs.set_tab_disabled(2, disabled)


func _on_form_button_pressed() -> void:
	OS.shell_open("https://forms.gle/1c113o8DWpJRwbFx9")
