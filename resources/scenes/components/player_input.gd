extends MultiplayerSynchronizer

@export var state := "rock"
@export var target: Vector2

func _ready():
	# Only process for the local player.
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

@rpc("call_local")
func update_target(new_target):
	target = new_target

@rpc("call_local")
func change_state(new_state):
	state = new_state

func _process(delta):
	if Input.is_action_pressed("click"):
		update_target.rpc(get_parent().get_global_mouse_position())	
		
	if Input.is_action_pressed("rock"):
		change_state.rpc("rock")
	elif Input.is_action_pressed("paper"):
		change_state.rpc("paper")
	elif Input.is_action_pressed("scissors"):
		change_state.rpc("scissors")
