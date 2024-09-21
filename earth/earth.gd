extends Node2D


var speed: float = -2 * PI / (24 * 60 * 60)
@export var thrust: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed += thrust * delta
	$Diffuse.rotation += speed * delta
