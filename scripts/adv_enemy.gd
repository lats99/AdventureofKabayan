class_name AdvEnemy extends Area2D

signal killed(points)

var speed = 300
var hp = 2
var points = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		die()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()
