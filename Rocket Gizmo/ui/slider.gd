class_name GizmoSlider
extends MarginContainer

# Instance variables for slider
@export var text: String
@export var min_value: int
@export var max_value: int
@export var step: int
@export var default_value: int

# Nodes it needs to access to modify or read values
@onready var label: Label = $Label
@onready var slider: HSlider = $HBoxContainer/HSlider
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit

func _ready() -> void:
	label.text = text
	slider.min_value = min_value
	slider.max_value = max_value
	slider.step = step
	slider.value = default_value
	line_edit.text = str(default_value)

func _on_slider_value_changed(value: float) -> void:
	if !line_edit.has_focus():
		line_edit.text = str(value)


func _on_line_edit_text_changed(new_text: String) -> void:
	# Return if text is not a number
	if !line_edit.text.is_valid_int():
		return
	var value: int = int(line_edit.text)
	if value >= min_value and value <= max_value:
		slider.value = value
	elif value < min_value:
		slider.value = min_value
	else:
		slider.value = max_value


func _on_line_edit_focus_exited() -> void:
	if (line_edit.text == ""):
		_on_slider_value_changed(0)
	else:
		_on_slider_value_changed(slider.value)
