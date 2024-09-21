@tool
extends EditorPlugin
var button_dock

func _enter_tree():
	button_dock = preload("res://addons/reloader/button.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, button_dock)
	button_dock.load_data()


func _exit_tree():
	remove_control_from_docks(button_dock)
	button_dock.free()
