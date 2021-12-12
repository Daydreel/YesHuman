extends Button

var expediteur = ""
var objet_mail = ""
var date_reception = ""

onready var expediteur_lbl = $MarginContainer/HBoxContainer/FromLabel
onready var objet_lbl = $MarginContainer/HBoxContainer/SubjectLabel
onready var date_lbl = $MarginContainer/HBoxContainer/DateLabel


func _ready():
	expediteur_lbl.text = expediteur
	objet_lbl.text = objet_mail
	date_lbl.text = date_reception

func _on_MailLign_pressed():
	print(self, " I have been pressed")
