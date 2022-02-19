tool
extends Button

onready var test = get_node("../DataManager")

func _on_PrintHello_pressed():
	print(test._read_data(test._mails_data_path))
