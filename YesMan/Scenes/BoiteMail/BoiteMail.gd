extends Control

export(String, FILE, "*.json") var mails_data_path
var _mail_lign_path = preload("res://GUI/Component/MailLign.tscn")
onready var _mail_list = $MailList

# Called when the node enters the scene tree for the first time.
func _ready():
	var mails = _load_data_mails_raw()
	for mail in mails:
		instance_mail_lign(mail["Expediteur"],mail["ObjetMail"], mail["DateReception"])


func _load_data_mails_raw():
	var file = File.new()
	file.open(mails_data_path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	var content = json.result
	return content

func instance_mail_lign(var expediteur = "", var objet_mail = "", var date_reception = ""):
	var mail_lign = _mail_lign_path.instance()
	mail_lign.expediteur = expediteur
	mail_lign.objet_mail = objet_mail
	mail_lign.date_reception = date_reception
	_mail_list.add_child(mail_lign)
	
