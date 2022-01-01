extends Node

#Visible variables
export var argent = 100
export var energy = 80

#Invisible variables
var humeur = 100
var exposition = 100
var charge_mentale = 100

#Signals
signal scene_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#Change scene with transition animation
#scene_name : the scene where to go
#animation_player : the animation to play for transition
#delay : the delay to wait before launch the transition
func _change_scene(scene_name, animation_player, delay = 0.1):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("TransitionOut")
	yield(animation_player, "animation_finished")
	get_tree().change_scene(scene_name)
	animation_player.play_backwards("TransitionOut")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")

func load_mail_info


#func _input(event):
#	if event is InputEventMouseButton:
#		print("Mouse Click/Unclick at: ", event)
