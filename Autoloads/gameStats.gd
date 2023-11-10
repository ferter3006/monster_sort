extends Node

signal level_progress_update(new_value : int)

var velocidadAnciano = false
var level_progress = 0: set = set_level_progress

var mapPlayin : int
var arrayCleareds : Array[bool]
var arrayPantallas : Array[String] = [
	"res://Escenas/Pantallas/Pantalla6/pantalla6.tscn",
	"res://Escenas/Pantallas/Pantalla0/pantalla_0.tscn",
	"res://Escenas/Pantallas/Pantalla1/pantalla_1.tscn",
	"res://Escenas/Pantallas/Pantalla2/pantalla_2.tscn",
	"res://Escenas/Pantallas/Pantalla3/pantalla_3.tscn",
	"res://Escenas/Pantallas/Pantalla4/pantalla_4.tscn",
	"res://Escenas/Pantallas/Pantalla5/pantalla_5.tscn"
]
var arrayPreviews : Array[String] = [
	"res://Assets/PantallasPreview/Pantalla6.jpg",
	"res://Assets/PantallasPreview/Pantalla0.jpg",
	"res://Assets/PantallasPreview/Pantalla1.jpg",
	"res://Assets/PantallasPreview/Pantalla2.jpg",
	"res://Assets/PantallasPreview/Pantalla3.jpg",
	"res://Assets/PantallasPreview/Pantalla4.jpg",
	"res://Assets/PantallasPreview/Pantalla5.jpg"
]
var arrayTitles : Array[String] = [
	"Easy First",
	"Vizzent vizzion",
	"Close but no",
	"Too many options",
	"Loop is Your Friend",
	"Relax its easy",
	"GizmoZpeed"
]

func _ready():
	init_cleareds()

func init_cleareds():
	for cosa in arrayPantallas:
		arrayCleareds.append(false)

func set_level_progress(newValue):
	level_progress = newValue
	level_progress_update.emit(level_progress)

func progress_tick(acierto : bool):
	if acierto:
		pass

func next_pantalla_is():
	pass
