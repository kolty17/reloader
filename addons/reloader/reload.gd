@tool
extends Control

var plugin: String = ""
var save_path := "res://addons/reloader/data.cfg"

func load_data():
	var config_file := ConfigFile.new()
	if FileAccess.file_exists(save_path):
		var error := config_file.load(save_path)
		if error: 
			print("An error happened while loading data: ", error)
			return
		$TextEdit.text = config_file.get_value("data", "plugin")

func _on_button_pressed():
	plugin = $TextEdit.text
	if $TextEdit.text == "": return
	if FileAccess.file_exists("res://addons/" + plugin + "/plugin.cfg"):
		EditorInterface.set_plugin_enabled(plugin, false)
		EditorInterface.set_plugin_enabled(plugin, true)
		write_label("👍 Plugin " + plugin + " reloaded", "success", .9)
	else:
		write_label("⚠ Cannot find plugin folder", "error")
	var config_file := ConfigFile.new()
	config_file.set_value("data", "plugin", plugin)
	var error := config_file.save(save_path)
	if error:
		write_label("An error happened while saving data: ", "error")

func write_label(text_to_write:String, alert:="info", time:=2.0):
	$Label.text = text_to_write
	match alert:
		"info":
			$Label.add_theme_color_override("font_color", Color.WHITE)
		"success":
			$Label.add_theme_color_override("font_color", Color.GREEN)
		"error":
			$Label.add_theme_color_override("font_color", Color.RED)
	$Label/delete_time.wait_time = time
	$Label/delete_time.start()

func _on_delete_time_timeout():
	$Label.text = ""
