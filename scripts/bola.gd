extends RigidBody2D
class_name Bola
var Numero: int
var esRayada: bool
const MAX_FORCE : int = 500
const SPRITE_OFFSET : int = 32

var current_rotation: Quaternion = Quaternion.IDENTITY
var accumulated_rotation: Quaternion = Quaternion.IDENTITY
var rotationSpeed = 0.0005
var xAxis = Vector3(1.0, 0.0, 0.0)


enum Bolas {
	BLANCA,
	LISA_AMARILLA,
	LISA_AZUL,
	LISA_ROJA,
	LISA_VIOLETA,
	LISA_NARANJA,
	LISA_VERDE,
	LISA_MARRON,
	NEGRA,
	RAYADA_AMARILLA,
	RAYADA_AZUL,
	RAYADA_ROJA,
	RAYADA_VIOLETA,
	RAYADA_NARANJA,
	RAYADA_VERDE,
	RAYADA_MARRON
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#contact_monitor = true		#Activado en editor || 'Solver' del Rigidbody
	#max_contacts_reported = 1	#Activado en editor || 'Solver' del Rigidbody
	$Sprite2D.get_material().set_shader_parameter("numeroDeBola", Numero)
	$Sprite2D.get_material().set_shader_parameter("quaternion", current_rotation)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var xRotation: float = 0.0
	var yRotation: float = 0.0
	xRotation = linear_velocity.y * rotationSpeed
	yRotation = -linear_velocity.x * rotationSpeed
	
	var xQuaternion: Quaternion = Quaternion(Vector3(1, 0, 0), xRotation)
	var yQuaternion: Quaternion = Quaternion(Vector3(0, 1, 0), yRotation)
	current_rotation = current_rotation * xQuaternion * yQuaternion
	current_rotation = current_rotation.normalized()
	
	$Sprite2D.get_material().set_shader_parameter("quaternion", current_rotation)
	#pass


func _on_body_entered(body: Node) -> void:
	#TODO: Make volume of sound depends on force of impact
	if body is Bola:
		var colliding_force = get_linear_velocity()
		colliding_force = snapped(sqrt((colliding_force.x ** 2) + (colliding_force.y ** 2)), 0.01)
		#colliding_force = snapped(colliding_force, 0.01)
		#colliding_force = abs(colliding_force)
		$AudioPlayer.volume_linear = inverse_lerp(0.0, MAX_FORCE, colliding_force)
		if (not $AudioPlayer.has_stream_playback()):
			$AudioPlayer.play()		#Play hit sound
			print(colliding_force)
		print("bola " + str(Numero) + " colisiono con bola " + str(body.Numero))
	else:
		pass
	
	
#func Hit(body: Node2D, collidingforce: ):
	#body.get_linear_velocity()
	#pass
