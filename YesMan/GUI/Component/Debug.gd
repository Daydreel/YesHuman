extends Control

onready var mood_label = $MarginContainer/VBoxContainer/MoodLabel
onready var fame_label = $MarginContainer/VBoxContainer/FameLabel
onready var workload_label = $MarginContainer/VBoxContainer/WorkloadLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	GS.connect("mood_changed",self, "_on_mood_changed")
	GS.connect("fame_changed",self, "_on_fame_changed")
	GS.connect("workload_changed",self, "_on_workload_changed")
	mood_label.text = "Mood : " + str(GS.mood)
	fame_label.text = "Fame : " + str(GS.fame)
	workload_label.text = "Workload : " + str(GS.workload)



func _on_mood_changed(value):
	mood_label.text = "Mood : " + str(value)

func _on_fame_changed(value):
	fame_label.text = "Fame : " + str(value)

func _on_workload_changed(value):
	workload_label.text = "Workload : " + str(value)
