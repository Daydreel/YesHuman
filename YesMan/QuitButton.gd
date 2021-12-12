extends TextureButton

export(NodePath) var popup_np

func _on_QuitButton_pressed():
	var popup = get_node(popup_np)
	popup.visible = true
