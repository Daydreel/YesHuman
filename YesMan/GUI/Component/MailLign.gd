extends Button

var id = ""
var from = ""
var object = ""
var date_received = ""
 
onready var expediteur_lbl = $MarginContainer/HBoxContainer/FromLabel
onready var objet_lbl = $MarginContainer/HBoxContainer/SubjectLabel
onready var date_lbl = $MarginContainer/HBoxContainer/DateLabel


func _ready():
	expediteur_lbl.text = from
	objet_lbl.text = object
	date_lbl.text = date_received
