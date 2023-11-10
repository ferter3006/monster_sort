extends Node2D

var arraySteps : Array[Node2D]
@onready var timer : Timer = $Timer
@onready var nodeSteps : Node2D = $Steps

var index_step = 0

func _ready():
	get_steps()


func get_steps():
	for child in nodeSteps.get_children():
		arraySteps.append(child)

func _on_timer_timeout():
	arraySteps[index_step].visible = true
	if index_step != 0:
		arraySteps[index_step - 1].visible = false
	if index_step < arraySteps.size() - 1:
		index_step += 1


func _on_exit_tutorial_pressed():
	get_tree().change_scene_to_file("res://Escenas/Home/home.tscn")
