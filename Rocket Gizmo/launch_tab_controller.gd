extends VBoxContainer

@onready var gravity_label: Label = $LabelGravity
@onready var distance_label: Label = $LabelDistance
@onready var launch_dropdown: OptionButton = $DropDownLaunch/OptionButton
@onready var goal_dropdown: OptionButton = $DropDownGoal/OptionButton
@onready var mass_label: MarginContainer = $MassLabel
@onready var fuel_amount: HSlider = $SliderFuelAmount/HBoxContainer/HSlider
@onready var fuel_type: OptionButton = $DropDownFuelType/OptionButton
@onready var play_button: Button = $TimeControlsContainer/ButtonPlay
@onready var pause_button: Button = $TimeControlsContainer/ButtonPause
@onready var restart_button: Button = $TimeControlsContainer/ButtonRestart

func _ready() -> void:
	launch_dropdown.item_selected.connect(change_gravity_label)
	goal_dropdown.item_selected.connect(change_distance_label)
	change_gravity_label(0)

func _process(delta: float) -> void:
	var mass: int = get_tree().root.get_child(0).global_mass
	var density: int #kg/ton
	# Liquid Oxygen, Liquid Hydrogen, Solid Fuel
	if fuel_type.selected == 0:
		density = 1141
	elif fuel_type.selected == 1:
		density = 70
	else:
		density = 1800
	
	mass += fuel_amount.value * density
	
	get_tree().root.get_child(0).global_fuel_mass = mass
	
	mass_label.update_label(mass / 907)

func change_gravity_label(_index: int) -> void:
	var text: String = "Gravity: "
	if launch_dropdown.selected == 0:
		get_tree().root.get_child(0).global_planet = "Earth"
		text += "9.8"
	elif launch_dropdown.selected == 1:
		get_tree().root.get_child(0).global_planet = "Moon"
		text += "1.62"
	else:
		get_tree().root.get_child(0).global_planet = "Mars"
		text += "3.71"
	text += " m/s²  "
	gravity_label.text = text
	change_distance_label(0)

func change_distance_label(_index: int) -> void:
	var initial_position: int
	if launch_dropdown.selected == 0:
		initial_position = 0
	elif launch_dropdown.selected == 1:
		initial_position = 384400
	else:
		initial_position = 225000000
	
	var final_position: int
	if goal_dropdown.selected == 0:
		final_position = 0
		get_tree().root.get_child(0).global_goal = "Earth"
	elif goal_dropdown.selected == 1:
		final_position = 384400
		get_tree().root.get_child(0).global_goal = "Moon"
	else:
		final_position = 225000000
		get_tree().root.get_child(0).global_goal = "Mars"
	
	var distance: int = abs(final_position - initial_position)
	if distance == 0:
		distance_label.text = "Select different launch and goal locations.  "
		disable_buttons()
	else:
		distance_label.text = str(distance) + " km away  "
		enable_buttons()

func disable_buttons() -> void:
	play_button.disabled = true
	pause_button.disabled = true
	restart_button.disabled = true

func enable_buttons() -> void:
	play_button.disabled = false
	pause_button.disabled = false
	restart_button.disabled = false
