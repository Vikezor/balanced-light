extends Node2D


var speed: float = -2 * PI / (24 * 60 * 60)
@export var thrust: float = 0
var time = 0
const physics_scale = 21600



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var scaled_delta = physics_scale * delta
	speed += thrust * scaled_delta
	$Rotator.rotation += speed * scaled_delta
	time += scaled_delta


func _on_sun_set_sun_rotation(rot: float) -> void:
	$Shading.rotation = rot
