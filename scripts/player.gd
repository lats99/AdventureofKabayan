class_name Player extends CharacterBody2D

signal bullets_shot (bullets_scene, location)

@export var speed = 300
var bullets_scene = preload("res://scenes/bullets.tscn")
@onready var muzzle: Marker2D = $Muzzle
var shoot_cd = false
@export var rate_of_fire = 0.2


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd=false

func _physics_process(delta: float) -> void: 
	var direction = Vector2(Input.get_axis("move_left", "move_right"),Input.get_axis("move_up", "move_down"))
	velocity = direction * speed
	move_and_slide()
	
func shoot():
	bullets_shot.emit(bullets_scene, muzzle.global_position)
	
func die():
	queue_free()
