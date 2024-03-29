@tool
extends EditorExportPlugin


func _get_name() -> String:
	return "XRToggleExport"


func _export_begin(features : PackedStringArray, _is_debug : bool, _path : String, _flags : int) -> void:
	# Force OpenXR on android
	if features.has("android"):
		ProjectSettings.set_setting("xr/openxr/enabled", true)


func _export_file(path : String, _type : String, _features : PackedStringArray) -> void:
	# Remove editor-only override file before exporting
	if path == "res://override.cfg":
		skip()
