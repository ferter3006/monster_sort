extends Node
class_name SelectorClass

@onready var area2D : Area2D = $Area2D
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animatedSpriteNext : AnimatedSprite2D = $AnimatedSpriteNext
@onready var paths : Node2D = $paths
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

@export_group("Conected Paths")
@export var IN1: PathClass
@export var IN2: PathClass
@export var IN3: PathClass
@export var IN4: PathClass
@export var OUT1: PathClass
@export var OUT2: PathClass
@export var OUT3: PathClass
@export var OUT4: PathClass

@export_group("Conexiones IN1")
@export var IN1_OUT2 : bool
@export var IN1_OUT3 : bool
@export var IN1_OUT4 : bool

@export_group("Conexiones IN2")
@export var IN2_OUT1 : bool
@export var IN2_OUT3 : bool
@export var IN2_OUT4 : bool

@export_group("Conexiones IN3")
@export var IN3_OUT1 : bool
@export var IN3_OUT2 : bool
@export var IN3_OUT4 : bool

@export_group("Conexiones IN4")
@export var IN4_OUT1 : bool
@export var IN4_OUT2 : bool
@export var IN4_OUT3 : bool

@export_group("Debug")
@export var info_debug = false

@export_group("Posicio Panel")
@export_enum("arriba", "derecha", "abajo", "izquierda") var direccio = 0

var current_option = 0
var current_option_next = 1

var diccionari_conexions : Array[Dictionary]

func _ready():
	connect_clicker()
	prepara_conexiones()
	conecta_actual()
	if info_debug: debug()
	
func debug():
	print("-----------------------")
	print(self.name)
	print("-----------------------")
	print("diccionari")
	print(diccionari_conexions)
	print("suma conexions")

func conecta_actual():
	var in_path : PathClass = diccionari_conexions[current_option]["in"] 
	var next_path : PathClass = diccionari_conexions[current_option]["path"] 
	var out_path : PathClass = diccionari_conexions[current_option]["out"] 
	var anim_name : String = diccionari_conexions[current_option]["animacion"]
	var anim_name_next : String = diccionari_conexions[current_option_next]["animacion"]
	var inversa : bool = diccionari_conexions[current_option]["inversa"]
	
	in_path.nextPath = next_path
	next_path.nextPath = out_path
	animatedSprite.play(anim_name)
	animatedSpriteNext.play(anim_name_next)
	if info_debug:
		print(self.name)
		print("\tConecto ", in_path, " a ", next_path)
		print("\tConecto ", next_path, " a ", out_path)	
	
	if inversa:
		var in_path_inv : PathClass = diccionari_conexions[current_option]["inv_in"] 
		var next_path_inv : PathClass = diccionari_conexions[current_option]["inv_path"] 
		var out_path_inv : PathClass = diccionari_conexions[current_option]["inv_out"] 
		in_path_inv.nextPath = next_path_inv
		next_path_inv.nextPath = out_path_inv

func connect_clicker():
	area2D.input_event.connect(change)

func change(_viewport, event : InputEvent, _shape):
	if event.is_action_pressed("click"):
		animationPlayer.play("click")
		Audios.selector_select.play()
		current_option = next_option(current_option)
		current_option_next = next_option(current_option_next)
		reset_conexions()
		conecta_actual()

func next_option(c_option):
	c_option += 1
	if c_option >= diccionari_conexions.size():
		c_option = 0
	return c_option

func anima_click():
	print("click")

func dic_apend(IN : PathClass, OUT : PathClass, string : String, inversa : bool = false, inv_IN : PathClass = null, inv_OUT : PathClass = null, inv_string : String = "IN1_OUT2"):
	diccionari_conexions.append({
			"in" : IN,
			"path" : paths.get_node(string),
			"out" : OUT,
			"animacion" : string,
			"inversa" : inversa,
			"inv_in" : inv_IN,
			"inv_path" : paths.get_node(inv_string),
			"inv_out" : inv_OUT
		})

func prepara_conexiones():
	if IN1_OUT2 && IN2_OUT1:
		dic_apend(IN1, OUT2, "IN1_OUT2", true, IN2, OUT1, "IN2_OUT1")
	elif IN1_OUT2:
		dic_apend(IN1, OUT2, "IN1_OUT2")
	elif IN2_OUT1:
		dic_apend(IN2, OUT1, "IN2_OUT1")
	
	if IN1_OUT3 && IN3_OUT1: 
		dic_apend(IN1, OUT3, "IN1_OUT3", true, IN3, OUT1, "IN3_OUT1")
	elif IN1_OUT3:
		dic_apend(IN1, OUT3, "IN1_OUT3")
	elif IN3_OUT1:
		dic_apend(IN3, OUT1, "IN3_OUT1")
		
	if IN1_OUT4 && IN4_OUT1: 
		dic_apend(IN1, OUT4, "IN1_OUT4", true, IN4, OUT1, "IN4_OUT1")
	elif IN1_OUT4 : 
		dic_apend(IN1, OUT4, "IN1_OUT4")
	elif IN4_OUT1 : 
		dic_apend(IN4, OUT1, "IN4_OUT1") 
	
	if IN2_OUT3 && IN3_OUT2: 
		dic_apend(IN2, OUT3, "IN2_OUT3", true, IN3, OUT2, "IN3_OUT2")
	elif IN2_OUT3 : 
		dic_apend(IN2, OUT3, "IN2_OUT3")
	elif IN3_OUT2 : 
		dic_apend(IN3, OUT2, "IN3_OUT2") 
	
	if IN2_OUT4 && IN4_OUT2: 
		dic_apend(IN2, OUT4, "IN2_OUT4", true, IN4, OUT2, "IN4_OUT2")
	elif IN2_OUT4 : 
		dic_apend(IN2, OUT4, "IN2_OUT4")
	elif IN4_OUT2 : 
		dic_apend(IN4, OUT2, "IN4_OUT2")
	
	if IN3_OUT4 && IN4_OUT3: 
		dic_apend(IN3, OUT4, "IN3_OUT4", true, IN4, OUT3, "IN4_OUT3") 
	elif IN3_OUT4 : 
		dic_apend(IN3, OUT4, "IN3_OUT4") 
	elif IN4_OUT3 : 
		dic_apend(IN4, OUT3, "IN4_OUT3")

func reset_conexions():
	if IN1 != null:
		IN1.nextPath = null
	if IN2 != null:
		IN2.nextPath = null
	if IN3 != null:
		IN3.nextPath = null
	if IN4 != null:
		IN4.nextPath = null
