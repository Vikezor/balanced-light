class_name SunPrediction
extends Line2D

@export var n: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(n):
		add_point(Vector2.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(n):
		set_point_position(i, Vector2(1152/2 - 245.0 + float(i) / (n-1) * 505.0, fmod(Sun.get_sun_rotation(float(i)/n * 10) / (2 * PI) + 1, 1) * 54 + 11))
