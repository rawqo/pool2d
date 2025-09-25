extends Node2D
const SPRITE_OFFSET : int = 64
const SPRITE_SIZE : = Vector2(64,64)

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
	const ESPACIO_ENTRE_BOLAS = 100
	var Bolita = load("res://assets/Bola.tscn").instantiate()
	Bolita.Numero = NumeroBola
	Bolita.esRayada = esBolaRayada
	Bolita.Valor = NumeroBola
	Bolita.name = "Bola_" + str(NumeroBola)
	Bolita.position.x = Bolita.position.x + (NumeroBola * ESPACIO_ENTRE_BOLAS)
	
	#Actualizar label con el numero de la bola
	if(NumeroBola % 10 == 6 || NumeroBola % 10 == 9):
		Bolita.get_child(-1).text = "[u]" + str(NumeroBola) + "[/u]"
	else:
		Bolita.get_child(-1).text = str(NumeroBola)
	
	#Asignar sprite correspondiente a cada bola
	if (NumeroBola < 8):
		Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2(NumeroBola*SPRITE_OFFSET,0), SPRITE_SIZE)
	else:
		Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2((NumeroBola-8)*SPRITE_OFFSET,SPRITE_OFFSET), SPRITE_SIZE)

	
	
	add_child(Bolita)

func asignarSprite(Numero: int):
	#Bolita.Textura.region = Rect2(Vector2(Bolita.Numero * 16, 0),Bolita.Textura.region.size)
	#Bolita.Textura.region = Rect2(Vector2(Bolita.Numero * 32, 32),Vector2(32,32))
	pass
