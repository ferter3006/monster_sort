extends Node2D

@onready var titleOfMap : Label = $Title
@onready var mapPreview : Sprite2D = $Preview
@onready var cleared : Node2D = $Cleared

var map_selection : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_preview()

func refresh_preview():
	titleOfMap.text = GameStats.arrayTitles[map_selection]
	mapPreview.texture = load(GameStats.arrayPreviews[map_selection])
	cleared.visible = GameStats.arrayCleareds[map_selection]

func _on_back_pressed():
	Audios.buton_menu.play()
	if map_selection > 0:
		map_selection -= 1
		refresh_preview()

func _on_start_pressed():
	Audios.buton_menu.play()
	GameStats.mapPlayin = map_selection
	get_tree().change_scene_to_file(GameStats.arrayPantallas[map_selection])

func _on_next_pressed():
	Audios.buton_menu.play()
	if map_selection < GameStats.arrayPreviews.size() - 1:
		map_selection += 1
		refresh_preview()
