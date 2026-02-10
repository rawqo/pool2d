extends Node2D
var contador_filas : int = 1
const ESPACIO_ENTRE_BOLAS = 202

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

var arrayNumerosBolas : Array = range(0, 15)
var bolasSpawneadas : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = self.position.y - (ESPACIO_ENTRE_BOLAS / 2)
	SpawnearEnTriangulo()
	#for unaBola in Bolas:
			#print("Spawneando: " + str(unaBola))
			#SpawnBola(Bolas[unaBola])
	
func SpawnBola(NumeroBola: int):
	var bolita = load("res://assets/Bola.tscn").instantiate()
	bolita.name = "Bola_" + str(NumeroBola)
	bolita.Numero = NumeroBola + 1
	CorregirLabel(bolita)
	CargarTextura(bolita)
	#Asignar sprite correspondiente a cada bola
	#if (NumeroBola < 8):
		#Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2(NumeroBola*SPRITE_OFFSET,0), SPRITE_SIZE)
	#else:
		#Bolita.get_node("Sprite2D").region_rect = Rect2(Vector2((NumeroBola-8)*SPRITE_OFFSET,SPRITE_OFFSET), SPRITE_SIZE)
	add_child(bolita)
	bolasSpawneadas.append(NumeroBola)
	return bolita

#Corregir label, en caso de que la bola termine en 6 o 9
func CorregirLabel(unaBola : Bola):
	if(unaBola.Numero % 10 == 6 || unaBola.Numero % 10 == 9):
		unaBola.get_child(-1).text = "[u]" + str(unaBola.Numero) + "[/u]"
	else:
		unaBola.get_child(-1).text = str(unaBola.Numero)
	
func CargarTextura(unaBola: Bola):
	var texturePath = "res://sprites/bolas/"
	texturePath = texturePath + str(unaBola.Numero) + ".png"
	var textura : Texture2D = load(texturePath)
	unaBola.get_node("Sprite2D").set_texture(textura)

func SpawnearEnTriangulo():
	var bolas_spawneadas = 0
	var bolaSpawneada
	var fila = 1
	while bolas_spawneadas < Bolas.size():
		for posicion_en_fila in fila:
			if bolas_spawneadas == 4:
				bolaSpawneada = SpawnBola(7)
			else:
				bolaSpawneada = SpawnBola(bolasSinSpawnear())
			PosicionarBola(bolaSpawneada, posicion_en_fila, fila)
			bolas_spawneadas = bolas_spawneadas + 1
		fila = fila + 1

func PosicionarBola(bola: Bola, posicionEnFila: int, numeroDeFila: int):
	bola.position.y = bola.position.y + (numeroDeFila * ESPACIO_ENTRE_BOLAS / 2)
	bola.position.y = bola.position.y - (posicionEnFila * ESPACIO_ENTRE_BOLAS)
	bola.position.x = bola.position.x - (numeroDeFila * ESPACIO_ENTRE_BOLAS)
			
func bolasSinSpawnear():
	var bolaASpawnear : int = arrayNumerosBolas.pick_random()
	while bolaASpawnear == 7 or bolasSpawneadas.has(bolaASpawnear):
		bolaASpawnear = arrayNumerosBolas.pick_random()
	return bolaASpawnear	

#
#func espacio_entre_bolas():
	#return randf_range(ESPACIO_ENTRE_BOLAS+1, ESPACIO_ENTRE_BOLAS+5)
