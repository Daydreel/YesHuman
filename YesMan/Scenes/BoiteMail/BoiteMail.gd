extends Control

export(String, FILE, "*.json") var mails_data_path
var _mail_lign_path = preload("res://GUI/Component/MailLign.tscn")
onready var _mail_list = $MailList
onready var _mail_display = $Mail

# Called when the node enters the scene tree for the first time.
func _ready():
	DataSystem.connect("mails_received",self,"_on_mails_received")
	DataSystem.get_new_mails()

func display_inbox_mails():
	#Empty list
	for mail_lign in _mail_list.get_children():
		mail_lign.queue_free()
	#Fill list with current mails
	for mail in DataSystem.mails:
		if mail["State"] == DataSystem.STATE_MAIL.INBOX :
			instance_mail_lign(mail["ID"],mail["From"],mail["Object"], mail["DateReceived"])


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
	mail_lign.connect("pressed", self, "display_current_mail", [id])
	_mail_list.add_child(mail_lign)

func display_current_mail(var id):
	GS.set_current_mail(id)
	if GS.current_mail == null:
		printerr("No current_mail in func : display_current_mail")
		return
	var current_mail = GS.current_mail
	#set_mail_data : 
	#from = "from", object = "object", 
	#content = "content", yes = "yes", no = "no"
	_mail_display.set_mail_data(current_mail["From"],current_mail["Object"], current_mail["Content"], current_mail["Yes"], current_mail["No"])
	_mail_display.show()


func _on_mails_received():
	display_inbox_mails()
