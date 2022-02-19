tool
extends VBoxContainer

var MailsList

#Displayers
var InputMailID
var InputMailFrom
var InputMailContent
var InputMailDateReceived
var InputMailNo
var InputMailYes
var InputMailConditions
var InputMailState
var InputMailResolution


func _enter_tree():
	MailsList = $"../../../MailsList"
	
	if !MailsList.is_connected("display_mail", self,"_on_ContentDisplayer_display_mail"):
		var err = MailsList.connect("display_mail",self,"_on_ContentDisplayer_display_mail")
		print(err)
	
	_set_displayers()

func _on_ContentDisplayer_display_mail(mail_data):
	print("display_mail_plugin")
	InputMailID.text = str(mail_data["ID"])
	InputMailFrom.text = str(mail_data["From"])
	InputMailContent.text = str(mail_data["Content"])
	InputMailDateReceived.text = str(mail_data["DateReceived"])
	InputMailNo.text = str(mail_data["No"])
	InputMailYes.text = str(mail_data["Yes"])
	InputMailConditions.text = str(mail_data["Conditions"])
	InputMailState.text = str(mail_data["State"])
	InputMailResolution.text = str(mail_data["Resolution"])


func _set_displayers():
	InputMailID = $InputMailID
	InputMailFrom = $InputMailFrom
	InputMailContent = $InputMailContent
	InputMailDateReceived = $InputMailDateReceived
	InputMailNo = $InputMailNo
	InputMailYes = $InputMailYes
	InputMailConditions = $InputMailConditions
	InputMailState = $InputMailState
	InputMailResolution = $InputMailResolution
