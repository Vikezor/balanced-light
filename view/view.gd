extends Node2D


var max_sun_time: float = 60 * 60 * 12
var elapsed_sun_time: float = .5 * max_sun_time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var earth_rotation = $Earth/Rotator.get_rotation()
	var sun_rotation = $Earth/Sun.get_sun_rotation()
	var earth_vector = Vector2(cos(earth_rotation), sin(earth_rotation))
	var sun_vector = Vector2(cos(sun_rotation), sin(sun_rotation))
	var difference = earth_vector.angle_to(sun_vector)
	$CanvasLayer/Label.text = "%f" % difference
	if difference > -.5 * PI && difference < .5 * PI:
		elapsed_sun_time += delta
	else:
		elapsed_sun_time -= delta
	$CanvasLayer/Bar.light_length = elapsed_sun_time / max_sun_time


func _on_time_scale_value_changed(value: float) -> void:
	Engine.time_scale = value


func _on_thrust_value_changed(value: float) -> void:
	$Earth.thrust = -value
