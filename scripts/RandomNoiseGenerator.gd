extends Sprite2D


# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	self.get_texture().get_noise().set_seed(randi() % 20)
	pass # Replace with function body.
