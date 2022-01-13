extends Control

func _ready():
  OS.window_position = (OS.get_screen_size()*0.5 - OS.window_size*0.5)


func _on_Button_Start_pressed():
	pass


func _on_Button_Settings_pressed():
	get_node("Control_Settings").show()


func _on_Button_Exit_pressed():
	get_tree().quit()
