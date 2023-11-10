extends CanvasLayer
class_name ResumenPantalla

@export var home : PackedScene
@onready var label_title : Label = $LabelTitle
@onready var retryLevel : Button = $ButtonRetryLevel

var text_win = "You Win!"
var text_lose = "Sorry you Lose!"
var resultado : bool

func resultado_win():
	label_title.text = text_win
	retryLevel.visible = false
	GameStats.arrayCleareds[GameStats.mapPlayin] = true
	
func resultado_lose():
	label_title.text = text_lose
	retryLevel.visible = true

func _on_button_go_home_pressed():
	Audios.buton_menu.play()
	get_tree().change_scene_to_packed(home)

func _on_button_retry_level_pressed():
	get_tree().reload_current_scene()
