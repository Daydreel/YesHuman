tool
extends ItemList

#Components
var ContentDisplayer

#Data
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
	ContentDisplayer = $"../../MailForm/Margin/ContentDisplayer"
	display_mail_list()
	select(0)


func display_mail_list():
	load_mails_data()
#Make sure to clean the list in case of artefacts or stranger things
	clear()
	for mail in _mails_data:
		add_item(mail["Object"])


func _get_last_mail_id():
	for mail in _mails_data:
		if int(mail["ID"]) > _last_id:
			_last_id = int(mail["ID"])
	return _last_id


func load_mails_data():
	_mails_data = _data_manager._read_data(_data_manager._mails_data_path)


func update_mails_data():
	_data_manager._update_data(_data_manager._mails_data_path, _mails_data)

func _exit_tree():
	clear()


func _on_MailsList_item_selected(index):
	emit_signal("display_mail", _mails_data[index])
	ContentDisplayer.show()


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
		"ID":str(_get_last_mail_id() + 1), 
		"Logo":"",
		"No":"", 
		"Object":"New Mail", 
		"Resolution":"", 
		"State":-1, 
		"Yes":""
	}
	_mails_data.append(new_mail)
	update_mails_data()
	add_item(new_mail["Object"])
	
	var _idx = get_item_count() - 1
	select(_idx)
	emit_signal("item_selected", _idx)


func _delete_selected_mail():
	if get_selected_items().size() > 0 :
		var _selected_item_idx = get_selected_items()[0]
		_mails_data.remove(_selected_item_idx)
		remove_item(_selected_item_idx)
		update_mails_data()
		ContentDisplayer.hide()


func _on_NewButton_pressed():
	_add_new_mail()


func _on_DeleteButton_pressed():
	_delete_selected_mail()
