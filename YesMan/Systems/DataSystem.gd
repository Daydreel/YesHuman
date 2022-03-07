extends Control

var _data_path = "res://Data/"
var _mails_data_path = _data_path + "Mails.json"
var _flags_data_path = _data_path + "Flags.json"
var _resolutions_data_path = _data_path + "Resolutions.json"

enum STATE_MAIL {NEW, INBOX, REPLIED}

var mails = []
var current_mails = []
var flags = {}
var conditions = {}
var resolutions = {}

signal mails_received

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_mails() #Always first !
	_set_conditions()
	_set_flags()
	set_resolutions()
	#NEXT STEP :
	#Get current mails then display them !

func get_new_mails():
	for mail in mails:
		if int(mail["State"]) == STATE_MAIL.NEW:
			var mail_conditions = mail["Conditions"].rsplit(",")
			var final_condition = "TRUE"
			
	#		print(conditions)
	#		Check for conditions on mails
			for condition in mail_conditions:
	#			print(flags.get(condition))
				if flags.get(condition) == "FALSE":
					final_condition = "FALSE"
			
	#		print(final_condition)
	#		Set mails to Inbox if they are new AND true for their conditions
			if  final_condition == "TRUE":
				mail["State"] = STATE_MAIL.INBOX
	emit_signal("mails_received")


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


func set_resolutions():
	var datas = _load_data(_resolutions_data_path)
	for data in datas:
		resolutions[data["ID"]] = [data["Yes"], data["No"], data["Ghosting"]]

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
