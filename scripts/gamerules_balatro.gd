extends Node

# Las reglas del rawpool:
# Cuando la bola blanca golpea a otra bola, se le suma
# el valor de la bola que impacto a la puntuacion.
# En caso de que golpee un borde, se le resta un valor (ej: -5) a la puntuacion.
# Cada tronera tiene su propia puntuacion, en caso de que
# una bola que no tiene dicho valor entra en la tronera, la diferencia de la tronera
# con la bola se resta de la puntuacion.



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
