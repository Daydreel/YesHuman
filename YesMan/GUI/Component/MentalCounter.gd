extends TextureRect

onready var mental_label = $MentalLabel

func _ready():
	GS.connect("mental_changed", self, "_on_mental_changed")
	mental_label.text = str(GS.get_mental_health())

func _on_mental_changed(value):
	mental_label.text = str(value)
