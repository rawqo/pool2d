# Inherits the ball script, so all the balls act the same.
extends Bola
var SHOOT_FORCE_FACTOR : int = 1000
var mouse_pos : Vector2
var shoot_pos : Vector2

func _ready() -> void:
	Numero = 0
	#$Label.text = str(Numero)
	#Textura = load("res://sprites/bolas/bola_0.png")
	#$Sprite2D.texture = Textura

func _process(_delta: float) -> void:
	calcular_rotacion_shader()
	
func _physics_process(_delta: float) -> void:
	
	if Input.is_action_pressed("shoot"):
		#mouse_pos = get_viewport().get_mouse_position()
		mouse_pos = get_global_mouse_position()
		shoot_pos = mouse_pos - self.position
		#FORCE_FACTOR = abs(force_pos)
		# TODO: Rework power system
		pass
	
	if Input.is_action_just_released("shoot"):
		apply_central_impulse(shoot_pos.normalized() * SHOOT_FORCE_FACTOR)
		
