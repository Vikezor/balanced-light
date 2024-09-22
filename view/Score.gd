extends Label

var time: float = 0
var lost: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !lost:
		time += delta
		text = "Score: %.02f" % time



func _on_earth_game_over_signal() -> void:
	lost = true
