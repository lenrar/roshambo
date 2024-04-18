extends MultiplayerSynchronizer

@export var position: Vector2:
	set(val):
		if is_multiplayer_authority():
			position = val
		else:
			get_parent().position = val

@export var rotation: float:
	set(val):
		if is_multiplayer_authority():
			rotation = val
		else:
			get_parent().rotation = val

@export var state: String:
	set(val):
		if is_multiplayer_authority():
			state = val
		else:
			get_parent().state = val
