extends Control

export(String, FILE, "*.json") var mails_data_path
var _mail_lign_path = preload("res://GUI/Component/MailLign.tscn")
onready var _mail_list = $MailList
onready var _mail = $Mail

# Called when the node enters the scene tree for the first time.
func _ready():
	var mails = _load_data_mails_raw()
	for mail in mails:
		instance_mail_lign(mail["ID"],mail["From"],mail["Object"], mail["DateReceived"])

func _load_data_mails_raw():
	var file = File.new()
	file.open(mails_data_path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	return content

func load_data_single_mail_raw(var id = -1):
	if id < 0:
		printerr("No ID for mail in func : load_data_single_mail_raw")
		return
	
	var file = File.new()
	file.open(mails_data_path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	for mail in content:
		if mail["ID"] == id:
			return mail
	return -1


func instance_mail_lign(var id = -1, var from = "", var object = "", var date_received = ""):
	var mail_lign = _mail_lign_path.instance()
	mail_lign.id = id
	mail_lign.from = from
	mail_lign.object = object
	mail_lign.date_received = date_received
	mail_lign._mail_box = self
	_mail_list.add_child(mail_lign)

func instance_mail(var id = -1):
	if id < 0:
		printerr("No ID for mail in func : instance_mail")
		return
	var mail_data = load_data_single_mail_raw(id)
	#set_mail_data : 
	#from = "from", object = "object", 
	#content = "content", yes = "yes", no = "no"
	_mail.set_mail_data(mail_data["From"],mail_data["Object"], mail_data["Content"], mail_data["Yes"], mail_data["No"])
	_mail.show()
