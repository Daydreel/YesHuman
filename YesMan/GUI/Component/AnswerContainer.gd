extends MarginContainer

var yes_text = "" setget set_yes_text, get_yes_text
var no_text = "" setget set_no_text, get_no_text

onready var _yes_lbl = $HBox/YesButton/CenterContainer/YesLabel
onready var _no_lbl = $HBox/NoButton/CenterContainer/NoLabel


func set_yes_text(var value = ""):
	yes_text = value
	_yes_lbl.text = value


func get_yes_text():
	return yes_text


func set_no_text(var value = ""):
	no_text = value
	_no_lbl.text = value


func get_no_text():
	return no_text

