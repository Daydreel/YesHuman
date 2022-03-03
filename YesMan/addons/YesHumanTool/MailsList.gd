tool
extends ItemList

var _data_manager
var _mails_data

#I know it's bad design, ID sould be handle by the DB. 
#This will wait for next time !
var _last_id = -1 #This if for adding a new mail with unique ID

signal display_mail

#Things to CRUD
#Conditions
#Content
#Object
#DateReceived
#From
#ID
#Logo
#No
#Yes
#State
#Resolution

func _enter_tree():
	_data_manager = $"../../../DataManager"
	display_mail_list()


func display_mail_list():
	load_mails_data()
#Make sure to clean the list in case of artefacts or stranger things
	clear()
	for mail in _mails_data:
		add_item(mail["Object"])
		if int(mail["ID"]) > _last_id:
			_last_id = int(mail["ID"])

func load_mails_data():
	_mails_data = _data_manager._read_data(_data_manager._mails_data_path)


func _exit_tree():
	clear()


func _on_MailsList_item_selected(index):
	emit_signal("display_mail", _mails_data[index])


func _on_MailsList_mail_data_updated():
	#Not super optimized but will be okay
	#I should reload the single updated data so I don't reload the full database
	#This is a problem for the futur me or someone else :p
	display_mail_list()

func _add_new_mail():
	var new_mail = {
		"Conditions":"", 
		"Content":"", 
		"DateReceived":"", 
		"From":"", 
		"ID":str(_last_id + 1), 
		"Logo":"",
		"No":"", 
		"Object":"New Mail", 
		"Resolution":"", 
		"State":-1, 
		"Yes":""
	}
	_mails_data.append(new_mail)
	_data_manager._update_data(_data_manager._mails_data_path, _mails_data)
	add_item(new_mail["Object"])


func _on_NewButton_pressed():
	_add_new_mail()


func _on_DeleteButton_pressed():
	pass # Replace with function body.
