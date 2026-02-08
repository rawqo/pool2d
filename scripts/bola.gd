extends RigidBody2D
class_name Bola
var Numero: int

var current_rotation: Quaternion = Quaternion.IDENTITY
var accumulated_rotation: Quaternion = Quaternion.IDENTITY
var rotationSpeed = 0.0002		#Vieja velocidad 0.0005
var xAxis = Vector3(1.0, 0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#contact_monitor = true		#Activado en editor || 'Solver' del Rigidbody
	#max_contacts_reported = 1	#Activado en editor || 'Solver' del Rigidbody
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	calcular_rotacion_shader()

func _on_body_entered(body: Node) -> void:
	#TODO: Make volume of sound depends on force of impact
	if body is Bola:
		if (not $AudioPlayer.has_stream_playback()):
			$AudioPlayer.play()		#Play hit sound
	else:
		pass
	
func calcular_rotacion_shader():
	var xRotation: float = 0.0
	var yRotation: float = 0.0
	xRotation = linear_velocity.y * rotationSpeed
	yRotation = -linear_velocity.x * rotationSpeed
	
	var xQuaternion: Quaternion = Quaternion(Vector3(1, 0, 0), xRotation)
	var yQuaternion: Quaternion = Quaternion(Vector3(0, 1, 0), yRotation)
	current_rotation = current_rotation * xQuaternion * yQuaternion
	current_rotation = current_rotation.normalized()
	
	$Sprite2D.get_material().set_shader_parameter("quaternion", current_rotation)

	
#func Hit(body: Node2D, collidingforce: ):
	#body.get_linear_velocity()
	#pass
