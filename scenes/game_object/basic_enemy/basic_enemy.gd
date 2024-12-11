extends CharacterBody2D
@export var MAX_SPEED = 40
@export var DAMAGE = 50
@onready var health_component: HealthComponent = $HealthComponent
@onready var basic_enemy_area: Area2D = $BasicEnemyArea

func _ready() -> void:
	basic_enemy_area.area_entered.connect(on_area_entered)

func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO


func on_area_entered(other_area: Area2D):
	health_component.take_damage(100)
