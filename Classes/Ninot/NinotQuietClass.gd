extends Node
class_name NinotQuietClass

@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animationPlayer : AnimationPlayer = $animacionLove/AnimationPlayer
@onready var colisionShape : CollisionShape2D = $Area2D/CollisionShape2D

func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	if area_parent is NinotClass:
		colisionShape.set_deferred("disabled", true)
		if area_parent.animatedSprite.animation == animatedSprite.animation:
			animationPlayer.play("love")
		else:
			animatedSprite.play("explosion")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "love":
		queue_free()

func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "explosion":
		queue_free()
