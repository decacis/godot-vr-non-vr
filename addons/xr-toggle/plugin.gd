@tool
extends EditorPlugin

var xr_toggle : CheckButton
var export_plugin : EditorExportPlugin


func _enter_tree() -> void:
	_create_export_plugin()
	_create_toggle_control()
	
	add_export_plugin(export_plugin)
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, xr_toggle)


func _create_export_plugin() -> void:
	if not export_plugin:
		export_plugin = EditorExportPlugin.new()
		export_plugin.set_script(load("res://addons/xr-toggle/export_plugin.gd"))

func _create_toggle_control() -> void:
	if not xr_toggle:
		xr_toggle = CheckButton.new()
		xr_toggle.text = "XR Enabled"
		xr_toggle.toggled.connect(_toggle_xr_mode)


func _toggle_xr_mode(toggled_on : bool) -> void:
	if FileAccess.file_exists("res://override.cfg"):
		DirAccess.remove_absolute("res://override.cfg")
	
	var config = ConfigFile.new()
	# Enable OpenXR
	config.set_value("xr", "openxr/enabled", toggled_on)
	# Save override file
	config.save("res://override.cfg")


func _exit_tree() -> void:
	if FileAccess.file_exists("res://override.cfg"):
		DirAccess.remove_absolute("res://override.cfg")
	
	if xr_toggle:
		xr_toggle.queue_free()
	
	remove_export_plugin(export_plugin)
	export_plugin = null
