extends CharacterBody2D
class_name Player


const MAX_SPEED = 800.0
const DECELERATION = 1.0

@onready var hand_sprite: Sprite2D = $HandSprite
@onready var synchronizer = $ServerSynchronizer

@export var player := 1 :
	set(id):
		player = id
		$PlayerInput.set_multiplayer_authority(id)
		
@onready var input = $PlayerInput
@onready var health = $HealthComponent

var players_in_attack_range = []

const ROCK_PAPER_SCISSORS_WINS = {
	'rock': 'scissors',
	'paper': 'rock',
	'scissors': 'paper'
}

func _ready():
	if player == multiplayer.get_unique_id():
		$Camera2D.enabled = true

func move_toward_target(delta):
	var to_target = input.target - global_position
	var distance = to_target.length()

	# Only attempt to move if we have a valid target distance
	if distance > 1.0:
		# Calculate the speed based on the remaining distance to the target
		var speed = min(distance / (DECELERATION * delta), MAX_SPEED)
		rotation = to_target.angle()
		velocity = to_target.normalized() * speed

		# Move the character
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		# Optionally, you can stop the character's movement when the target is reached
		move_and_slide()

func attack(attack_hand):
	if ROCK_PAPER_SCISSORS_WINS[attack_hand] == input.state:
		health.take_damage(1)
	
	

func attack_players():
	for p in players_in_attack_range:
		p.attack(input.state)

func _physics_process(delta):	
	hand_sprite.set_state(input.state)
	move_toward_target(delta)
	attack_players()


func _on_attack_area_body_entered(body):
	if body is Player:
		players_in_attack_range.append(body)
		

func _on_attack_area_body_exited(body):
	if body is Player:
		players_in_attack_range.erase(body)

func die():
	hand_sprite.hide()
	$HitBox.disabled = true
	$AttackArea/AttackBox.disabled = true

func _on_health_component_health_depleted():
	die()
