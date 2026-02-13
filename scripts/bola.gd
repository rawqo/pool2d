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
func _physics_process(_delta: float) -> void:
	calcular_rotacion_shader()


func _on_body_entered(body: Node) -> void:
	#TODO: Make volume of sound depends on force of impact
	if body is Bola:
		if (not $AudioPlayer.has_stream_playback()):
			$AudioPlayer.play()		#Play hit sound
	
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


func _on_area_deteccion_area_entered(area: Area2D) -> void:
	call_deferred("EliminarBola", area)

func EliminarBola(tronera) -> void:
	self.set_freeze_enabled(true)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", tronera.global_position, 0.2)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "scale", Vector2(), 0.3)
	tween.tween_callback(self.queue_free)
