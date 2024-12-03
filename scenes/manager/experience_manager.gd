extends Node

var current_exp = 0
func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
	
	
func increment_exp(number: float):
	current_exp += number
	print(current_exp)

func on_experience_vial_collected(number: float):
	increment_exp(number)
