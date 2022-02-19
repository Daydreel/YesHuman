tool
extends Node

const _data_path = "res://Data/"
const _mails_data_path = _data_path + "Mails.json"
const _flags_data_path = _data_path + "Flags.json"
const _resolutions_data_path = _data_path + "Resolutions.json"


func create_data():
	pass


func _read_data(var path : String):
	var file = File.new()
	file.open(path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	return content


func _update_data():
	pass


func _delete_data():
	pass
