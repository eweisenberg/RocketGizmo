extends VBoxContainer

@onready var gravity_label: Label = $LabelGravity
@onready var distance_label: Label = $LabelDistance
@onready var launch_dropdown: OptionButton = $DropDownLaunch/OptionButton
@onready var goal_dropdown: OptionButton = $DropDownGoal/OptionButton

func _ready() -> void:
	launch_dropdown.item_selected.connect(change_gravity_label)
	goal_dropdown.item_selected.connect(change_distance_label)
	change_gravity_label(0)

func change_gravity_label(_index: int) -> void:
	var text: String = "Gravity: "
	if launch_dropdown.selected == 0:
		text += "9.8"
	elif launch_dropdown.selected == 1:
		text += "1.62"
	else:
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
	elif goal_dropdown.selected == 1:
		final_position = 384400
	else:
		final_position = 225000000
	
	var distance: int = abs(final_position - initial_position)
	if distance == 0:
		distance_label.text = "Select different launch and goal locations.  "
	else:
		distance_label.text = str(distance) + " km away  "
