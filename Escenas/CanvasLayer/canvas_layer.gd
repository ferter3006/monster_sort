extends CanvasLayer

@onready var label_level : Label = $Node2D/Label_level
@onready var progress_bar : TextureProgressBar = $Node2D/Level_ProgresBar
@onready var menuPopUp : Node2D = $MenuPopUp

func _ready():
	level_update()
	GameStats.level_progress_update.connect(level_progress_update)
	menuPopUp.visible = false

func level_update():
	label_level.text = "Progress"

func level_progress_update(value):
	progress_bar.value = value

func _on_menu_button_pressed():
	get_tree().paused = !get_tree().paused
	menuPopUp.visible = get_tree().paused
	button_sound()

func button_sound():
	Audios.buton_menu.play()
