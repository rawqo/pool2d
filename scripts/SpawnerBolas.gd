extends Node2D
const SPRITE_OFFSET : int = 64
const SPRITE_SIZE : = Vector2(64,64)
var textura_rayada : Texture2D = load("res://sprites/bolas/base_rayada.png")
var textura_lisa : Texture2D = load("res://sprites/bolas/base_lisa.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for Bolas in Bola.Bolas:
		if (Bolas != "BLANCA"):
			print("Spawneando: " + str(Bolas))
			SpawnBola(Bola.Bolas[Bolas], false)
		
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func SpawnBola(NumeroBola: int, esBolaRayada : bool):
	const ESPACIO_ENTRE_BOLAS = 200
	var Bolita = load("res://assets/Bola.tscn").instantiate()
	Bolita.Numero = NumeroBola
	Bolita.esRayada = esBolaRayada
	Bolita.name = "Bola_" + str(NumeroBola)
	Bolita.position.x = Bolita.position.x + (NumeroBola * ESPACIO_ENTRE_BOLAS)
	
	#Actualizar label con el numero de la bola
	if(NumeroBola % 10 == 6 || NumeroBola % 10 == 9):
		Bolita.get_child(-1).text = "[u]" + str(NumeroBola) + "[/u]"
	else:
		Bolita.get_child(-1).text = str(NumeroBola)
	
	
	
	#Asignar sprite correspondiente a cada bola
	#if (NumeroBola < 8):
		#Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2(NumeroBola*SPRITE_OFFSET,0), SPRITE_SIZE)
	#else:
		#Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2((NumeroBola-8)*SPRITE_OFFSET,SPRITE_OFFSET), SPRITE_SIZE)

	if (NumeroBola % 16 < 9):
		Bolita.get_node("Sprite2D").set_texture(textura_lisa)
	else:
		Bolita.get_node("Sprite2D").set_texture(textura_rayada)
	
	add_child(Bolita)
