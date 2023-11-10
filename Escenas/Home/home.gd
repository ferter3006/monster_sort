extends Node2D

@onready var how_to_play : Node2D = $HowToPlay
@onready var map_selector: Node2D = $MapSelector

func _ready():
	Audios.fondo.stop()
	how_to_play.visible = false

func _process(_delta):
	pass

func _on_how_to_play_pressed():
	how_to_play.init_tuto()
	how_to_play.visible = true
	map_selector.visible = false
	Audios.buton_menu.play()

func _on_about_pressed():
	Audios.buton_menu.play()
	get_tree().change_scene_to_file("res://Escenas/About/about.tscn")

func _on_exit_pressed():
	get_tree().quit()
