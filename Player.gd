extends KinematicBody2D

var velocity = Vector2.ZERO
var score = 0

onready var main = get_tree().get_current_scene()
onready var end = main.get_node("Wall6")
onready var a = preload("res://Wall.tscn")

func _physics_process(delta):
	
	velocity.y += 15
	if velocity.y > 150:
		velocity.y = 150
	
	if Input.is_key_pressed(KEY_SPACE):
		velocity.y = -150
	
	move_and_slide(velocity)


func _on_Area1_body_entered(body):
	if body.is_in_group("wall"):
		body.queue_free()
		var b = a.instance()
		b.position = Vector2(end.position.x+96,rand_range(-30,30))
		end = b
		main.add_child(b)
		
		score += 1
		get_tree().get_current_scene().get_node("CanvasLayer/Panel/Label").text = str(score)


func _on_Area2_body_entered(body):
	if body.is_in_group("wall"):
		get_tree().paused = true


func _on_Button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
