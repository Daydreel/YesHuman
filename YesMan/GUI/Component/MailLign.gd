extends Button

var id = ""
var from = ""
var object = ""
var date_received = ""

var _mail_box #reference to mailbox for mail ID
 
onready var expediteur_lbl = $MarginContainer/HBoxContainer/FromLabel
onready var objet_lbl = $MarginContainer/HBoxContainer/SubjectLabel
onready var date_lbl = $MarginContainer/HBoxContainer/DateLabel


func _ready():
	expediteur_lbl.text = from
	objet_lbl.text = object
	date_lbl.text = date_received

func _on_MailLign_pressed():
	_mail_box.instance_mail(id)
