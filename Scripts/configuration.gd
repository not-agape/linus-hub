extends Node

const User_directory = "user://"
const Res_directory = "res://"
const Settings_Path = Res_directory + "Settings.cfg"

# 0 : File didn't open
# 1 : File open
enum {LOAD_ERROR_COULDNT_OPEN, LOAD_SUCCESS}

var config = ConfigFile.new()

var Settings = {
	"Display": 
	{
		"HEIGHT" : 720,
		"WIDTH" :1280,
		"FullScreen":false
	},
	"AUDIO":
	{
		"MUSIC": 8,
		"SOUND_EFFECTS":8
	}
}


func _ready():
	
	# Check if settings.ini exist if not create a new one with the default Settings
	if _load_Settings() == LOAD_ERROR_COULDNT_OPEN :
		_save_Settings()
	_apply_Settings()


func _load_Settings():

	# Check for error if true exist the function else parse the file and load the config settings into Settings
	var error = config.load(Settings_Path)

	if error != OK:
		print("Error loading the settings. Error code: %s" % error)
		return LOAD_ERROR_COULDNT_OPEN

	for section in Settings.keys():
		for key in Settings[section]:
			var val = config.get_value(section,key)
			Settings[section][key] = val

	return LOAD_SUCCESS


# Save the Settings into the config file if the config file dosen't exist create a new one
func _save_Settings():
	
	for section in Settings.keys():
		for key in Settings[section]:
			config.set_value(section,key,Settings[section][key])
	
	config.save(Settings_Path)


func _apply_Settings():
	
	OS.window_size = Vector2(Settings.Display.WIDTH,Settings.Display.HEIGHT)
	OS.window_fullscreen = Settings.Display.FullScreen


# Only function that's call outside of this scripts
func update_Settings(H, W, Full, Audio):
	
	Settings.Display.HEIGHT = H
	Settings.Display.WIDTH = W
	Settings.Display.FullScreen = Full
	Settings.AUDIO.MUSIC = Audio.x
	Settings.AUDIO.SOUND_EFFECTS = Audio.y
	
	#Saving the file than applying it
	_save_Settings()
	_apply_Settings()
