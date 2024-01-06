extends Node3D


@export var height : float = 1.7 :
	get:
		return height
	set(value):
		height = value
		if not Engine.is_editor_hint():
			_handle_height()

@export var sensitivity : float = 0.005

@onready var head_pivot = $HeadPivot
@onready var head_camera = $HeadPivot/HeadCamera


func _handle_height() -> void:
	head_pivot.position.y = height


func _ready() -> void:
	_handle_height()


func _process(_delta : float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED \
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE \
		else Input.MOUSE_MODE_VISIBLE
		

func _input(event) -> void:
	if event is InputEventMouseMotion:
		var ev : InputEventMouseMotion = event
		head_pivot.rotate_y(-ev.relative.x * sensitivity)
		head_camera.rotate_x(-ev.relative.y * sensitivity)
		
		head_camera.rotation.x = clampf(head_camera.rotation.x, -PI/2.0, PI/2.0)
