extends Node2D


var max_sun_time: float = 60 * 60 * 12
var elapsed_sun_time: float = .5 * max_sun_time
const physics_scale = 21600 # 4 seconds / day


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.physics_ticks_per_second = 60 * 8 # 8 is the default max physics ticks per frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var scaled_delta = delta * physics_scale
	var earth_rotation = $Earth/Rotator.get_rotation()
	var sun_rotation = $Earth/Sun.get_sun_rotation()
	var earth_vector = Vector2(cos(earth_rotation), sin(earth_rotation))
	var sun_vector = Vector2(cos(sun_rotation), sin(sun_rotation))
	var difference = earth_vector.angle_to(sun_vector)
	$CanvasLayer/Label.text = "%f" % difference
	if difference > -.5 * PI && difference < .5 * PI:
		elapsed_sun_time += scaled_delta
	else:
		elapsed_sun_time -= scaled_delta
	$CanvasLayer/Bar.light_length = elapsed_sun_time / max_sun_time


func _on_thrust_value_changed(value: float) -> void:
	$Earth.thrust = -value
