class_name GizmoSlider
extends MarginContainer

@export var text: String
@export var min_value: int
@export var max_value: int
@export var step: int
@export var default_value: int

@onready var label = $Label
@onready var slider = $HBoxContainer/HSlider
@onready var line_edit = $HBoxContainer/LineEdit

func _ready() -> void:
	label.text = text
	slider.min_value = min_value
	slider.max_value = max_value
	slider.step = step
	slider.value = default_value
	line_edit.text = str(default_value)

func _on_slider_value_changed(value: float) -> void:
	line_edit.text = str(value)
