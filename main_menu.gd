extends Control

@onready var settings_popup = $SettingsPopup
@onready var help_popup = $SettingsPopup/HelpPopup

# --- MAIN MENU BUTTONS ---
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://game_menu.tscn")

func _on_settings_pressed() -> void:
	settings_popup.visible = true  # Show the settings window

func _on_exit_pressed() -> void:
	get_tree().quit()

# --- SETTINGS WINDOW BUTTONS ---
func _on_back_button_pressed() -> void:
	settings_popup.visible = false # Hide the settings window

func _on_help_pressed() -> void:
	help_popup.visible = true      # Show the help window

# --- HELP WINDOW BUTTONS ---
func _on_close_pressed() -> void:
	help_popup.visible = false     # Hide the help window

# --- SLIDER LOGIC ---

# 1. Volume Control
func _on_volume_slider_value_changed(value: float) -> void:
	# value / 100 converts 0-100 to 0-1 range
	var volume_db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

# 2. Brightness Control (Simple Print for now)
func _on_brightness_slider_value_changed(value: float) -> void:
	# value is usually 0 to 100
	print("Adjusting brightness to: ", value)
	# To make this work visually, you can modulate a black ColorRect's alpha
