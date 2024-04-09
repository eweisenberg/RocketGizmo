extends MarginContainer

@export var text: String
@export var items_comma_separated: String

@onready var label: Label = $Label
@onready var dropdown: OptionButton = $OptionButton

func _ready() -> void:
	label.text = text
	var items_arr: Array = items_comma_separated.split(", ")
	for item in items_arr:
		dropdown.add_item(" " + item)
