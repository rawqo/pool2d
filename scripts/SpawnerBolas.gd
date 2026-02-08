extends Node2D

#var textura_rayada : Texture2D = load("res://sprites/bolas/base_rayada.png")
#var textura_lisa : Texture2D = load("res://sprites/bolas/base_lisa.png")
var contador_filas : int = 1

enum Bolas {
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
	for unaBola in Bolas:
			print("Spawneando: " + str(unaBola))
			SpawnBola(Bolas[unaBola])
		
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func SpawnBola(NumeroBola: int):
	const ESPACIO_ENTRE_BOLAS = 210
	var Bolita = load("res://assets/Bola.tscn").instantiate()
	Bolita.name = "Bola_" + str(NumeroBola)
	Bolita.Numero = NumeroBola + 1
	Bolita.position.x = Bolita.position.x + (NumeroBola * ESPACIO_ENTRE_BOLAS)
	Bolita.position.y = Bolita.position.y + (contador_filas * ESPACIO_ENTRE_BOLAS)
	
	# spawnear hilera de 1 bola, despues 2, 3, 4, 5... hasta quedarme sin bolas
	# cada bola spawnea con la separacion definida por ESPACIO_ENTRE_BOLAS
	# por cada vez que termino de spawnear una hilera, paso a spawnear
	# verticalmente ESPACIO_ENTRE_BOLAS
	# horizontalmente ESPACIO_ENTRE_BOLAS / 2
		
	
	CorregirLabel(Bolita)
	CargarTextura(Bolita)
	
	#Asignar sprite correspondiente a cada bola
	#if (NumeroBola < 8):
		#Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2(NumeroBola*SPRITE_OFFSET,0), SPRITE_SIZE)
	#else:
		#Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2((NumeroBola-8)*SPRITE_OFFSET,SPRITE_OFFSET), SPRITE_SIZE)

	
	add_child(Bolita)

func ObtenerTexturasDisponibles():
	var arrayDeTexturas : Array = []
	return arrayDeTexturas

#Corregir label, en caso de que la bola termine en 6 o 9
func CorregirLabel(unaBola : Bola):
	if(unaBola.Numero % 10 == 6 || unaBola.Numero % 10 == 9):
		unaBola.get_child(-1).text = "[u]" + str(unaBola.Numero) + "[/u]"
	else:
		unaBola.get_child(-1).text = str(unaBola.Numero)
	
#Actualizar textura en base a si es lisa o rayada
func ActualizarTextura(unaBola : Bola):
	var texturas = ObtenerTexturasDisponibles()
	if (unaBola.Numero % 16 < 9):
		unaBola.get_node("Sprite2D").set_texture(texturas[unaBola.Numero])
	else:
		unaBola.get_node("Sprite2D").set_texture(texturas[unaBola.Numero])

func CargarTextura(unaBola: Bola):
	var texturePath = "res://sprites/bolas/"
	texturePath = texturePath + str(unaBola.Numero) + ".png"
	var textura : Texture2D = load(texturePath)
	unaBola.get_node("Sprite2D").set_texture(textura)
