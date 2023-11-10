extends CheckButton

var textLabel : Array[String] = [
	"Normal speed",
	"Low speed (anciano artrítico)"
	]
@onready var label = $Label

func _ready():
	button_pressed = GameStats.velocidadAnciano
	label.text = textLabel[0] if !GameStats.velocidadAnciano else textLabel[1]

func _on_toggled(button_pressedT):
	Audios.selector_select.play()
	GameStats.velocidadAnciano = button_pressedT
	label.text = textLabel[0] if !GameStats.velocidadAnciano else textLabel[1]
