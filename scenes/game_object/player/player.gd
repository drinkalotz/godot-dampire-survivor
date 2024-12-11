extends CharacterBody2D

@export var MAX_SPEED = 125
@export var acceleration_smoothing = 25
@onready var health_component: HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.died.connect(on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * acceleration_smoothing))
	move_and_slide()


func get_movement_vector():
	# for josticks, returns fractional numbers instead of 1,0,-1
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func _on_player_hurt_box_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	health_component.take_damage(enemy.DAMAGE)
	
func on_player_died():
	queue_free()
