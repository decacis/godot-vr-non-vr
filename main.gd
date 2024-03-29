extends Node3D

const NON_VR_RIG : PackedScene = preload("res://Rigs/NonVR/non_vr_rig.tscn")
const VR_RIG : PackedScene = preload("res://Rigs/VRRig/VRRig.tscn")

var openxr_enabled : bool = false


func _ready() -> void:
	# Get command line arguments
	var args : PackedStringArray = OS.get_cmdline_args()
	
	# Is OpenXR enabled? (Editor)
	if OS.has_feature("editor"):
		openxr_enabled = ProjectSettings.get_setting("xr/openxr/enabled", false)
	
	# Release/debug build
	else:
		var xr_interface : XRInterface = XRServer.find_interface("OpenXR")
		if xr_interface and xr_interface.is_initialized():
			openxr_enabled = true
		
		if args.has("--restart-with-xr") and not openxr_enabled:
			print("Failed to start OpenXR")
	
	print("OpenXR Enabled: ", openxr_enabled)
	
	var rig : Node3D
	if not openxr_enabled:
		rig = NON_VR_RIG.instantiate()
		# Connect Desktop UI button
		rig.request_xr_restart.connect(_restart_with_xr)
	else:
		rig = VR_RIG.instantiate()
	
	add_child(rig)


func _restart_with_xr() -> void:
	# Only runs when exported (either debug or release)
	if OS.has_feature("template"):
		var pid : int = -1
		match OS.get_name():
			"Windows":
				pid = OS.create_process("cmd.exe", ["/c", "\"%s\"" % OS.get_executable_path() + " --xr-mode on --restart-with-xr"])
			"Linux":
				pid = OS.create_process("bash", ["-c", "\"%s\"" % OS.get_executable_path() + " --xr-mode on --restart-with-xr"])
			_:
				print("Unsupported OS.")
		
		# Process created, now quit.
		if pid != -1:
			get_tree().quit()
		
		else:
			# TODO: Unable to create process for some reason. Inform the user.
			pass
