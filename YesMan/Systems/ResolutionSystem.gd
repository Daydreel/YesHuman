extends Control

var resolutions = {}
enum ANSWER {YES, NO, GHOSTING}

onready var mail_ui : MarginContainer

func _ready():
	resolutions = DataSystem.resolutions

func resolve_mail(var answer):
	var _resolution = ""
	
#	Get resolutions from database 
#	Then look for corresponding resolution with id_resolution
#	Select resolution from answer 0 = Yes 1 = No 2 = Ghosting
	if resolutions.get(GS.current_mail["Resolution"]) != null:
		_resolution = resolutions.get(GS.current_mail["Resolution"])[answer]
#	print(_resolution)
	for modifier in _resolution.rsplit(","):
		var value = modifier.rsplit("=")
		match value[0]: #TODO - factoriser ça dans un fichier de config
			"Flag":
				modify_flag(value[1])
			"Money":
				modify_money(value[1])
			"Mental":
				modify_mental(value[1])
			"Mood":
				modify_mood(value[1])
			"Fame":
				modify_fame(value[1])
			"Workload":
				modify_workload(value[1])
			_:
				print(value[0], "This outcome not yet implemented")
	GS.current_mail["State"] = DataSystem.STATE_MAIL.REPLIED
	mail_ui.hide()
	process_mails()


func modify_flag(var flag : String):
	if DataSystem.flags.has(flag):
		DataSystem.flags[flag] = "TRUE"

func modify_money(var money : String):
	GS.calculate_money(int(money))

func modify_mental(var mental : String):
	GS.calculate_mental(int(mental))

func modify_mood(var mood : String):
	GS.calculate_mood(int(mood))

func modify_fame(var fame : String):
	GS.calculate_fame(int(fame))

func modify_workload(var workload : String):
	GS.calculate_workload(int(workload))

func process_mails():
	DataSystem.get_new_mails()
