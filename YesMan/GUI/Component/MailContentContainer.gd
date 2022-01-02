extends MarginContainer

var text = "" setget set_text, get_text
onready var _label = $CenterContainer/MailContentBackground/MarginContainer/MailContentLabel

func set_text(var value):
	text = value
	_label.text = value


func get_text():
	return text
