# Inherits the ball script, so all the balls act the same.
extends Bola
var FORCE_FACTOR : int = 300
var mouse_pos : Vector2
var force_pos : Vector2

func _ready() -> void:
	Numero = 0
	#$Label.text = str(Numero)
	#Textura = load("res://sprites/bolas/bola_0.png")
	#$Sprite2D.texture = Textura

func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	pass
	
	
func _physics_process(_delta: float) -> void:
	
	if Input.is_action_pressed("shoot"):
		force_pos = mouse_pos - self.position
		#FORCE_FACTOR = abs(force_pos)
		# TODO: Rework power system
		pass
	
	if Input.is_action_just_released("shoot"):
		apply_central_impulse(force_pos.normalized() * FORCE_FACTOR)
		#print("lanzando bola...")
		
