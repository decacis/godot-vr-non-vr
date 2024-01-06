extends Node3D

const NON_VR_RIG : PackedScene = preload("res://Rigs/NonVR/non_vr_rig.tscn")
const VR_RIG : PackedScene = preload("res://Rigs/VRRig/VRRig.tscn")

var openxr_enabled : bool = false


func _ready() -> void:
	# Remove the override settings. They are used to start with OpenXR enabled
	# in the editor, but after that they can be removed for the next start
	_project_started()
	
	# Is OpenXR enabled?
	openxr_enabled = ProjectSettings.get_setting("xr/openxr/enabled", false)
	
	print("OpenXR Enabled: ", openxr_enabled)
	
	var rig : Node3D
	if not openxr_enabled:
		rig = NON_VR_RIG.instantiate()
	else:
		rig = VR_RIG.instantiate()
	
	add_child(rig)


func _restart_with_xr() -> void:
	# This is for an exported game.
	OS.set_restart_on_exit(true, ["--xr-mode on"])
	
	# And this is for the editor.
	if OS.is_debug_build():
		var config = ConfigFile.new()
		# Enable OpenXR
		config.set_value("xr", "openxr/enabled", true)
		# Save override file
		config.save("res://override.cfg")
	
	get_tree().quit()


func _project_started() -> void:
	if OS.is_debug_build() and FileAccess.file_exists("res://override.cfg"):
		print("Removing override file")
		DirAccess.remove_absolute("res://override.cfg")


func _input(event) -> void:
	# When pressing ENTER the game will quit and
	# the next start will be in VR
	if event is InputEventKey:
		var ev : InputEventKey = event
		if ev.is_action_pressed("ui_accept"):
			if not openxr_enabled:
				print("Next start will have OpenXR enabled.")
				_restart_with_xr()
