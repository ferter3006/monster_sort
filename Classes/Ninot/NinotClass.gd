extends Node
class_name NinotClass

var path_follow : PathFollow2D
var path : PathClass
var pantalla : PantallaClass

var velocity
var new_tween : Tween

var ninot_color = ""
@onready var velocity_per = pantalla.velocity_ninot
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animationPlayer : AnimationPlayer = $animacionLove/AnimationPlayer
@onready var collisionShape : CollisionShape2D = $Area2D/CollisionShape2D

func _ready():
	animatedSprite.play(ninot_color)
	path_follow = get_parent()
	path_follow.rotates = false
	path = path_follow.get_parent()
	
	calcula_velocity()
	init_twin()
	
func init_twin():
	calcula_velocity()
	new_tween = create_tween()
	path_follow.progress_ratio = 0
	new_tween.tween_property(path_follow, "progress_ratio", 1, velocity)
	new_tween.tween_callback(end_path)

func end_path():
	if path.nextPath == null:
		print("Me muero por que ", path, " no te nextPath")
		destroy_me()
	else:
		path.remove_child(path_follow)
		path = path.nextPath
		path.add_child(path_follow)
		init_twin()

func destroy_me():
	Audios.audio_explosion.play()
	Audios.audio_oh_no.play()
	animatedSprite.play("explosion")
	pantalla.progress_tick(false)

func color(x):
	ninot_color = x

func calcula_velocity():
	if path is Path2D:
		velocity = path.curve.get_baked_length() / 64 * velocity_per

func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "explosion":
		get_parent().queue_free()

func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	if area_parent is NinotQuietClass:
		new_tween.stop()
		collisionShape.set_deferred("disabled", true)
		if area_parent.animatedSprite.animation == animatedSprite.animation:
			animationPlayer.play("love")
			Audios.audio_love.play()
			pantalla.progress_tick(true)
		else:
			new_tween.stop()
			destroy_me()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "love":
		get_parent().queue_free()
