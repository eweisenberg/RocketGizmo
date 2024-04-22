extends Control

var global_mass: int
var global_fuel_mass: int
var global_engines: int
var global_height: int
var global_diameter: int
var global_nose: int
var global_material: int
var global_planet: String

var sec_played: float = 0.0

@onready var time_label: Label = $TimeLabel

func _process(delta: float) -> void:
	sec_played += delta
	if sec_played < 10:
		time_label.text = " Time played: " + str(int(sec_played) / 60) + ":0" + str(int(sec_played) % 60)
	else:
		time_label.text = " Time played: " + str(int(sec_played) / 60) + ":" + str(int(sec_played) % 60)
