tool
extends ItemList

var _data_manager
var _mails_data

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
	_data_manager = $"../../DataManager"
	_mails_data = _data_manager._read_data(_data_manager._mails_data_path)
#Make sure to clean the list in case of artefacts or stranger things
	clear()
	for mail in _mails_data:
		add_item(mail["Object"])


func _exit_tree():
	clear()

func _on_MailsList_item_selected(index):
	emit_signal("display_mail", _mails_data[index])
