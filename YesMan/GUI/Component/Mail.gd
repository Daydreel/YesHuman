extends MarginContainer

var _from_mail = "From"
var _object_mail = "Subject"
var _content_mail = "Content"
var _yes_answer = "Yes"
var _no_answer = "No"

onready var _from = $Panel/MailBodyContainer/FromContainer
onready var _object = $Panel/MailBodyContainer/ObjectContainer
onready var _mail_content = $Panel/MailBodyContainer/MailContentContainer
onready var _anwser = $Panel/MailBodyContainer/AnswerContainer

func _ready():
	ResolutionSystem.mail_ui = self

func set_mail_data(from = "from", object = "object", content = "content", yes = "yes", no = "no"):
	_from_mail = from
	_object_mail = object
	_content_mail = content
	_yes_answer = yes
	_no_answer = no
	display_mail_data()

# Called when the node enters the scene tree for the first time.
func display_mail_data():
	_from.text = _from_mail
	_object.text = _object_mail
	_mail_content.text = _content_mail
	_anwser.yes_text = _yes_answer
	_anwser.no_text = _no_answer


func hide():
	visible = false

func show():
	visible = true

func _on_CloseMailButton_pressed():
	hide()
	GS.unset_current_mail()
