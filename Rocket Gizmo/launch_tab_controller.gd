extends VBoxContainer

@onready var gravity_label: Label = $LabelGravity
@onready var distance_label: Label = $LabelDistance
@onready var launch_dropdown: OptionButton = $DropDownLaunch/OptionButton
@onready var goal_dropdown: OptionButton = $DropDownGoal/OptionButton

func _ready() -> void:
	launch_dropdown.item_selected.connect(change_gravity_label)
	change_gravity_label(0)

func change_gravity_label(index) -> void:
	var text: String = "Gravity: "
	if launch_dropdown.selected == 0:
		text += "9.8"
	elif launch_dropdown.selected == 1:
		text += "0"
	elif launch_dropdown.selected == 2:
		text += "1.62"
	else:
		text += "3.71"
	text += " m/s²  "
	gravity_label.text = text
