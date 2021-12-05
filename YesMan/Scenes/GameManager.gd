extends Node2D

#Text used to display Energy
onready var energy_text = get_node("Energy")
#Text used to display Argent
onready var argent_text = get_node("Argent")
onready var animation_player = $AnimationPlayer
onready var contenu_text = $infos
onready var expediteur_text = $infos
onready var date_text = $infos
onready var oui_text = $infos

export(String, FILE, "*.tscn") var scene_where_to_go
var _current_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_init_mail()
	animation_player.play_backwards("TransitionOut")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	_current_scene = get_tree().get_current_scene().filename
	energy_text.text = str(GS.energy)
	argent_text.text = str(GS.argent)
	pass # Replace with function body.
	
func _on_Button_pressed():
	GS._change_scene(scene_where_to_go, animation_player)
	#if _current_scene == "res://Scenes/ZoneFab.tscn":
	#	GS._change_scene("res://Scenes/ZoneFab2.tscn", animation_player)
	#elif _current_scene == "res://Scenes/ZoneFab2.tscn":
	#	GS._change_scene("res://Scenes/ZoneFab.tscn",animation_player)
		
func _init_mail():
	var file = File.new()
	file.open("res://Assets/mails.json", File.READ)
	var text = file.get_as_text()
	file.close()
	
	var mails = JSON.parse(text).result
	var mail = mails["mails"]
	contenu_text.text = str(mail[0]["contenu"])
	pass
