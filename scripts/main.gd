extends Node2D

const SCROLL_SPEED : int = 25

@export var enemy_scenes: Array[PackedScene] = []
@onready var player_spawn_pos: Marker2D = $PlayerSpawnPos
@onready var bullets_container: Node2D = $BulletsContainer
@onready var enemy_container: Node2D = $EnemyContainer
@onready var hud: Control = $CanvasLayer/HUD
@onready var game_over: Control = $CanvasLayer/GameOver
@onready var parallax_background: ParallaxBackground = $ParallaxBackground

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var high_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var save_file = FileAccess.open("user://KabayanJetpackSave.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game() 
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	game_over.visible=false

func save_game():
	var save_file = FileAccess.open("user://KabayanJetpackSave.data", FileAccess.WRITE)
	save_file.store_32(high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parallax_background.scroll_offset.y += SCROLL_SPEED * delta
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_bullets_shot(bullets_scene: Variant, location: Variant) -> void:
	var bullets = bullets_scene.instantiate()
	bullets.global_position = location
	bullets_container.add_child(bullets)

func _on_enemy_spawn_timer_timeout() -> void:
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 814), -50)
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)
	
func _on_enemy_killed(points):
	score += points
	if score > high_score:
		high_score = score
	print(score)
	
func _on_player_killed() -> void:
	game_over.set_score(score)
	game_over.set_high_score(high_score)
	save_game()
	await get_tree().create_timer(1.5).timeout
	game_over.visible = true
