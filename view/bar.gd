extends Sprite2D


@export var light_length = .5
var bar_length = 256

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$LightMask.polygon[2].x = light_length * bar_length
	$LightMask.polygon[3].x = light_length * bar_length
	$Separator.position.x = light_length * bar_length - bar_length / 2



func _on_earth_set_light_length(light: float) -> void:
	light_length = light
