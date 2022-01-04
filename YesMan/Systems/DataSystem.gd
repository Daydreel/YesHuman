extends Control

var _data_path = "res://Data/"
var _mails_data_path = _data_path + "Mails.json"
var _flags_data_path = _data_path + "Flags.json"
var _resolutions_data_path = _data_path + "Resolutions.json"

var mails
var current_mails
var flags = {}
var conditions = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_mails() #Always first !
	_set_conditions()
	_set_flags()
	print(flags)
	print(conditions)
	#NEXT STEP :
	#Get current mails then display them !


func _load_data_mails_raw():
	var file = File.new()
	file.open(_mails_data_path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	return content


func _set_mails():
	mails = _load_data(_mails_data_path)


func _set_flags():
	var datas = _load_data(_flags_data_path)
	for data in datas :
		flags[data["Flag"]] = data["State"]


func _set_conditions():
	if mails == null:
		_set_mails()
	for mail in mails :
		conditions[mail["ID"]] = mail["Conditions"]


func _load_data(var path : String):
	var file = File.new()
	file.open(path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	return content


func load_data_single_mail_raw(var id = -1):
	if id < 0:
		printerr("No ID for mail in func : load_data_single_mail_raw")
		return
	
	var file = File.new()
	file.open(_mails_data_path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	for mail in content:
		if mail["ID"] == id:
			return mail
	return -1
