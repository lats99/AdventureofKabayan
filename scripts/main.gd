extends Node2D

const SCROLL_SPEED : int = 25
var player = null
@onready var player_spawn_pos: Marker2D = $PlayerSpawnPos
@onready var bullets_container: Node2D = $BulletsContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.bullets_shot.connect(_on_player_bullets_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ParallaxBackground.scroll_offset.y += SCROLL_SPEED * delta
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_bullets_shot(bullets_scene: Variant, location: Variant) -> void:
	var bullets = bullets_scene.instantiate()
	bullets.global_position = location
	bullets_container.add_child(bullets)
