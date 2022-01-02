extends MarginContainer


var text = "" setget set_text, get_text
onready var _label = $HBoxContainer/Control/FromBackground/MarginContainer/FromLabel

func set_text(var value):
	text = value
	_label.text = value


func get_text():
	return text
