extends Node


@onready var audio_explosion : AudioStreamPlayer = $explosion
@onready var audio_love : AudioStreamPlayer = $love
@onready var audio_oh_no : AudioStreamPlayer = $ohno
@onready var selector_select : AudioStreamPlayer = $selector_select
@onready var buton_menu : AudioStreamPlayer = $bong

@onready var fondo : AudioStreamPlayer = $Fondo/fondo
@onready var win : AudioStreamPlayer = $Fondo/win
@onready var lose : AudioStreamPlayer = $Fondo/lose

var volum100 = 0
var volum50 = -15
var audiosBusIndex = 1
var musicBusIndex = 2

var soundsVolumen = 100:
	set(value):
		soundsVolumen = value
		sound_changed(value)

var musicVolumen = 100:
	set(value):
		musicVolumen = value
		music_changed(value)

func sound_changed(value):
	if value == 100:
		AudioServer.set_bus_mute(audiosBusIndex,false)
		AudioServer.set_bus_volume_db(audiosBusIndex, volum100)
	elif value == 50:
		AudioServer.set_bus_mute(audiosBusIndex,false)
		AudioServer.set_bus_volume_db(audiosBusIndex, volum50)
	elif value == 0:
		AudioServer.set_bus_mute(audiosBusIndex,true)

func music_changed(value):
	if value == 100:
		AudioServer.set_bus_mute(musicBusIndex,false)
		AudioServer.set_bus_volume_db(musicBusIndex, volum100)
	elif value == 50:
		AudioServer.set_bus_mute(musicBusIndex,false)
		AudioServer.set_bus_volume_db(musicBusIndex, volum50)
	elif value == 0:
		AudioServer.set_bus_mute(musicBusIndex,true)

func _on_fondo_finished():
	fondo.play()
