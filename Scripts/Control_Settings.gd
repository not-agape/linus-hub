extends Control


var Display = {"h" : 0,"w":0}
var Audio = Vector2()
var String_spliter
var Muted 
var Fullscreen
var Vsync


func _ready():
  _update_settings()


func _update_settings():
  get_node("Blur Mask/Horizontal/V1/Fullscreen/CheckBox_Fullscreen").pressed = configuration.Settings.Display.FullScreen
  get_node("Blur Mask/Horizontal/V2/Volume_Music/HS_Music").value = configuration.Settings.AUDIO.MUSIC
  get_node("Blur Mask/Horizontal/V2/Volume_SFX/HS_SFX").value = configuration.Settings.AUDIO.SOUND_EFFECTS
  Display.h = configuration.Settings.Display.HEIGHT
  Display.w = configuration.Settings.Display.WIDTH
  Fullscreen = get_node("Blur Mask/Horizontal/V1/Fullscreen/CheckBox_Fullscreen").pressed
  Audio = Vector2(configuration.Settings.AUDIO.MUSIC, configuration.Settings.AUDIO.SOUND_EFFECTS)
  _check_resolution()


func _check_resolution():
	var NB = get_node("Blur Mask/Horizontal/V1/Resolution/OptionButton_Res").get_item_count()
	for i in NB:
		String_spliter = get_node("Blur Mask/Horizontal/V1/Resolution/OptionButton_Res").get_item_text(i).split("x")
		if String_spliter[1] == String(configuration.Settings.Display.HEIGHT) && String_spliter[0] == String(configuration.Settings.Display.WIDTH):
			get_node("Blur Mask/Horizontal/V1/Resolution/OptionButton_Res").select(i)


func _on_HS_Music_value_changed(value):
  Audio.x = value


func _on_HS_SFX_value_changed(value):
  Audio.y = value
  

# Call up the function in the singleton to update the settings
func _on_Button_Save_pressed():
	configuration.update_Settings(Display.h, Display.w, Fullscreen, Audio)
	self.hide()


func _on_OptionButton_Res_item_selected(index):
	String_spliter = get_node("Blur Mask/Horizontal/V1/Resolution/OptionButton_Res").get_item_text(index)
	String_spliter = String_spliter.split("x")
	Display.h = String_spliter[1]
	Display.w = String_spliter[0]


func _on_CheckBox_Fullscreen_toggled(button_pressed):
	Fullscreen = button_pressed
