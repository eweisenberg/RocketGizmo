extends VBoxContainer

@onready var mass_label: MarginContainer = $MassLabel
@onready var engines: HSlider = $SliderEngines/HBoxContainer/HSlider
@onready var height: HSlider = $SliderHeight/HBoxContainer/HSlider
@onready var diameter: HSlider = $SliderDiameter/HBoxContainer/HSlider
@onready var mat: OptionButton = $DropDownMaterial/OptionButton

var mass: int

func _process(delta: float) -> void:
	mass = 0
	var density: int #kg/m^3
	# Aluminum, Titanium, Carbon composite
	if mat.selected == 0:
		density = 2700
	elif mat.selected == 1:
		density = 4500
	else:
		density = 1800
	mass += density * PI * (diameter.value / 2) ** 2 * height.value
	
	mass += engines.value * 5000
	
	get_tree().root.get_child(0).global_mass = mass
	get_tree().root.get_child(0).global_engines = engines.value
	
	mass_label.update_label(mass / 907)
