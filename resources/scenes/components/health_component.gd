extends Node
class_name HealthComponent

@export var max_health = 1
var health = max_health

signal health_changed(old_value, new_value)
signal health_depleted

func change_health(new_health):
		health_changed.emit(health, new_health)
		health = new_health
	

func take_damage(amount):
	if health > 0:
		change_health(health - amount)

	if health <= 0:
		health_depleted.emit()
		

func heal_damage(amount):
	if health < max_health:
		change_health(min(health + amount, max_health))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
