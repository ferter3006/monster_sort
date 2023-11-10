extends Node
class_name PantallaClass

enum colors{BEIGE,BLAU,GROC,ROSA,VERD}
var ninot_Scene = preload("res://Escenas/Ninots/ninot.tscn")

@onready var spawn_point : AnimatedSprite2D = $SpawnPoint
@export var first_path : PathClass
@export var spawner_tick_time : float = 0.5
@export var ArrayNinots : Array[colors]
@export var resumenPantalla : PackedScene = preload("res://Escenas/FinalPantalla/resumen_pantalla.tscn")
@export var velocity_ninot = 0.5
@onready var spawnerTimer = Timer.new()
@onready var timer_final = Timer.new()

var indexArraySpawn = 0
var num_aciertos = 0
var num_usados = 0

func _ready():
	check_anciano()
	init_spawner()
	init_timer_final()
	spawn_color_refresh()
	Audios.fondo.play()

func check_anciano():
	if GameStats.velocidadAnciano:
		spawner_tick_time *= 2
		velocity_ninot *= 2

func spawn_color_refresh():
	var color = colors.keys()[ArrayNinots[indexArraySpawn]]
	spawn_point.play(color)

func init_timer_final():
	timer_final.timeout.connect(resumen_final)
	timer_final.wait_time = 1.5
	timer_final.one_shot = true
	add_child(timer_final)

func init_spawner():
	# Inicialitzem timer spawner
	spawnerTimer.timeout.connect(spawn_tick)
	spawnerTimer.wait_time = spawner_tick_time
	spawnerTimer.one_shot = false
	add_child(spawnerTimer)
	spawnerTimer.start()

func spawn_tick():
	add_ninot()
	
func add_ninot():
	# posem ninot al first_path
	var newPF = PathFollow2D.new()
	var ninot = ninot_Scene.instantiate()
	if ninot is NinotClass:
		var color = colors.keys()[ArrayNinots[indexArraySpawn]].to_lower()
		ninot.color(color)
		ninot.pantalla = self
	newPF.add_child(ninot)
	first_path.add_child(newPF)
	act_index()

func act_index():
	# Actualitzem index. Parem tick si cal.
	indexArraySpawn += 1
	if indexArraySpawn >= ArrayNinots.size():
		spawnerTimer.stop()
	else:
		spawn_color_refresh()

func progress_tick(acierto : bool):
	if acierto:
		var numero_ninots = ArrayNinots.size()
		num_aciertos += 1
		var progreso =  100.0 / numero_ninots * num_aciertos
		GameStats.level_progress = progreso

	num_usados += 1
	if num_usados == ArrayNinots.size():
		Audios.fondo.stop()
		timer_final.start() ## timeout -> resumen_final

func resumen_final():
	var new_resumen = resumenPantalla.instantiate()
	if new_resumen is ResumenPantalla:
		add_child(new_resumen)
		if num_aciertos == ArrayNinots.size():
			Audios.win.play()
			new_resumen.resultado_win()
		else:
			Audios.lose.play()
			new_resumen.resultado_lose()
