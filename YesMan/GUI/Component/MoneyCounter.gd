extends TextureRect

onready var money_label = $MoneyLabel

func _ready():
	GS.connect("money_changed", self, "_on_money_changed")
	money_label.text = str(GS.get_money())

func _on_money_changed(value):
	money_label.text = str(value)
