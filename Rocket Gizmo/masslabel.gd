extends MarginContainer

@export var with_fuel: bool

@onready var label: Label = $Label

func _ready() -> void:
	update_label(0)

func update_label(mass: int) -> void:
	var text: String = "Mass: "
	text += str(mass)
	text += " tons ("
	if with_fuel:
		text += "with"
	else:
		text += "without"
	text += " fuel)"
	label.text = text
