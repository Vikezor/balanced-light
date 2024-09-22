extends Node2D

signal set_light_length
signal game_over_signal

var speed: float = -2 * PI / (24 * 60 * 60)
var lost: bool = false
var light_length: float = 0.5
@export var thrust_strength = 3
@export var max_turning_speed = 10
var time = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var thrust_control = Input.get_action_strength("right_thrust") - Input.get_action_strength("left_thrust")
	
	if abs(thrust_control) > 0.5:
		($Thruster as AudioStreamPlayer2D).playing = true
	else:
		($Thruster as AudioStreamPlayer2D).playing = false
		
	if !lost:
		speed += thrust_control * thrust_strength * delta
	if abs(speed) > max_turning_speed and !lost:
		($PeopleFlying as CPUParticles2D).emitting = true
		($Scream as AudioStreamPlayer2D).play()
		game_over() 
	#speed = clamp(speed, -max_turning_speed, max_turning_speed)
	$Diffuse.rotation += speed * delta
	
	time += delta
	
	if lost:
		if Input.is_action_pressed("restart"):
			get_tree().reload_current_scene()
	

func game_over():
	lost = true
	game_over_signal.emit()


func _on_sun_set_sun_rotation(rot: float) -> void:
	$Shading.rotation = rot
	if !lost:
		var light = Vector2(sin(rot), cos(rot)).dot(Vector2(cos($Diffuse.rotation), -sin($Diffuse.rotation)))
		light_length += light / 256 * get_process_delta_time() * 45
		if light_length > 1:
			($Diffuse/Fire as AnimatedSprite2D).visible = true
			($Diffuse/Fire as AnimatedSprite2D).play()
			($Fire_noise as AudioStreamPlayer2D).play()
			game_over()
		elif light_length < 0:
			($Diffuse/Ice as AnimatedSprite2D).visible = true
			($Diffuse/Ice as AnimatedSprite2D).play()
			($Ice_noise as AudioStreamPlayer2D).play()
			game_over()
		set_light_length.emit(light_length)
