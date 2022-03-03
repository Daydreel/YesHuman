tool
extends VBoxContainer

var MailsList
var DataManager

#Displayers
var InputMailObject
var InputMailID
var InputMailFrom
var InputMailContent
var InputMailDateReceived
var InputMailNo
var InputMailYes
var InputMailConditions
var InputMailState
var InputMailResolution

var _form_inputs = []

#Signals
signal mail_data_updated

func _enter_tree():
	MailsList = $"../../../VBoxContainer/MailsList"
	DataManager = $"../../../../DataManager"
	
	if !MailsList.is_connected("display_mail", self,"_on_ContentDisplayer_display_mail"):
		var err = MailsList.connect("display_mail",self,"_on_ContentDisplayer_display_mail")
	
	if !is_connected("mail_data_updated", MailsList,"_on_MailsList_mail_data_updated"):
		var err = connect("mail_data_updated", MailsList,"_on_MailsList_mail_data_updated")
	
	_set_displayers()
	MailsList.emit_signal("item_selected", 0)

func _on_ContentDisplayer_display_mail(mail_data):
	InputMailObject.text = str(mail_data["Object"])
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
	InputMailObject = $InputMailObject
	_form_inputs.append(InputMailObject)
	
	InputMailID = $HBox/InputMailID
	_form_inputs.append(InputMailID)
	
	InputMailFrom = $HBox/InputMailFrom
	_form_inputs.append(InputMailFrom)
	
	InputMailContent = $InputMailContent
	_form_inputs.append(InputMailContent)
	
	InputMailDateReceived = $HBox/InputMailDateReceived
	_form_inputs.append(InputMailDateReceived)
	
	InputMailNo = $HBox2/InputMailNo
	_form_inputs.append(InputMailNo)
	
	InputMailYes = $HBox2/InputMailYes
	_form_inputs.append(InputMailYes)
	
	InputMailConditions = $HBox3/InputMailConditions
	_form_inputs.append(InputMailConditions)
	
	InputMailState = $HBoxContainer/InputMailState
	_form_inputs.append(InputMailState)
	
	InputMailResolution = $HBox3/InputMailResolution
	_form_inputs.append(InputMailResolution)


func _get_forms_data():
	var _new_data_mail = {
		"Conditions":"", 
		"Content":"", 
		"DateReceived":"", 
		"From":"", 
		"ID":-1, 
		"Logo":"",
		"No":"", 
		"Object":"", 
		"Resolution":"", 
		"State":-1, 
		"Yes":""
		}
	
	for child in _form_inputs:
		if child is TextEdit:
			for key in _new_data_mail:
				if key in child.name:
					_new_data_mail[key] = child.text
	return _new_data_mail

func _on_ButtonUpdateData_pressed():
	var _data = DataManager._read_data(DataManager._mails_data_path)
	var _updated_entry = _get_forms_data()
	var i = 0
	for entry in _data:
		if str(entry["ID"]) == _updated_entry["ID"] :
			_data[i] = _updated_entry
			DataManager._update_data(DataManager._mails_data_path, _data)
			emit_signal("mail_data_updated")
			return
		i += 1

func hide():
	visible = false

func show():
	visible = true
