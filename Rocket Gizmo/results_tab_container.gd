extends VBoxContainer

@onready var summary: RichTextLabel = $Label

func _process(delta: float) -> void:
	var engines = get_tree().root.get_child(0).global_engines
	var mass = get_tree().root.get_child(0).global_fuel_mass
	var thrust: float = (engines * 4000000) / (9.07 * mass / 907 * 9.81)
	var text: String = ""
	if thrust >= 5:
		text += "Your rocket had enough thrust to launch."
	else :
		text += "Your rocket did not have enough thrust to launch."
	summary.text = text
