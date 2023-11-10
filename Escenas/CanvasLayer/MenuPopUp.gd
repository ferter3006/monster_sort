extends Node2D

@onready var button_sounds : Button = $Sounds
@onready var button_music : Button = $Music

func _ready():
	inicia_marcadors_audio()

func _on_resume_pressed():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	button_sound()

func _on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = !get_tree().paused
	button_sound()

func _on_music_pressed():
	modifica_music_volumen()
	button_sound()

func _on_sounds_pressed():
	modifica_sounds_volumen()
	button_sound()

func button_sound():
	Audios.buton_menu.play()

func modifica_sounds_volumen():
	if Audios.soundsVolumen == 100:
		Audios.soundsVolumen = 50
		button_sounds.text = "Sounds 50%"
	elif Audios.soundsVolumen == 50:
		Audios.soundsVolumen = 0
		button_sounds.text = "Sounds 0%"
	elif Audios.soundsVolumen == 0:
		Audios.soundsVolumen = 100
		button_sounds.text = "Sounds 100%"

func modifica_music_volumen():
	if Audios.musicVolumen == 100:
		Audios.musicVolumen = 50
		button_music.text = "Music 50%"
	elif Audios.musicVolumen == 50:
		Audios.musicVolumen = 0
		button_music.text = "Music 0%"
	elif Audios.musicVolumen == 0:
		Audios.musicVolumen = 100
		button_music.text = "Music 100%"

func _on_home_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/Home/home.tscn")

func inicia_marcadors_audio():
	if Audios.soundsVolumen == 100:
		button_sounds.text = "Sounds 100%"
	elif Audios.soundsVolumen == 50:
		button_sounds.text = "Sounds 50%"
	elif Audios.soundsVolumen == 0:
		button_sounds.text = "Sounds 0%"
	
	if Audios.musicVolumen == 100:
		button_music.text = "Music 100%"
	elif Audios.musicVolumen == 50:
		button_music.text = "Music 50%"
	elif Audios.musicVolumen == 0:
		button_music.text = "Music 0%"
