extends Node
@export var spear_ability: PackedScene
@onready var timer: Timer = $Timer
const MAX_RANGE = 300
@export var speed = 300
var local_spear_instance = null
var local_enemy_instance = null
var local_enemy_direction: Vector2 = Vector2.ZERO
func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	
func _process(delta: float) -> void:
	if local_spear_instance == null or local_enemy_instance == null:
		return
	local_enemy_direction = local_enemy_instance.global_position - local_spear_instance.global_position	
	local_enemy_direction = local_enemy_direction.normalized()
	local_spear_instance.global_position += local_enemy_direction * speed * delta
	local_spear_instance.rotation = local_enemy_direction.angle()

		
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return
	var spear_instance = spear_ability.instantiate() as Node2D
	local_spear_instance = spear_instance
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	local_enemy_instance = enemies[0]
	player.get_parent().add_child(spear_instance)
	local_spear_instance.global_position = player.global_position
	#spear_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	var enemy_direction = local_enemy_instance.global_position - local_spear_instance.global_position
	local_spear_instance.rotation = enemy_direction.angle()
