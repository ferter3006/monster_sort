extends Node2D

@export var map_selector: Node2D
var arraySteps : Array[Node2D]
var index = 0

func _ready():
	for child in get_children():
		if child.get_class() == "Node2D":
			arraySteps.append(child)

func init_tuto():
	index = 0
	actualiza_tuto()

func actualiza_tuto():
	make_visible(index)

func make_visible(step):
	for node_step in arraySteps:
		if node_step == arraySteps[step]:
			node_step.visible = true
		else:
			node_step.visible = false

func _on_prev_pressed():
	Audios.buton_menu.play()
	if index > 0:
		index -= 1
		actualiza_tuto()

func _on_exit_pressed():
	Audios.buton_menu.play()
	visible = false
	map_selector.visible = true

func _on_next_pressed():
	Audios.buton_menu.play()
	if index < arraySteps.size() - 1:
		index += 1
		actualiza_tuto()
