extends Node2D
@onready var experience_area: Area2D = $ExperienceArea


func _ready() -> void:
	experience_area.area_entered.connect(on_area_entered)
	
func on_area_entered(other_area: Area2D):
	GameEvents.emit_experience_vial_collected(1)
	queue_free()	
