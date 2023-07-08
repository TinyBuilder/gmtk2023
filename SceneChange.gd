extends ColorRect
@export_file("*.tscn") var next_scene_path
@onready var _anim_player = $Fade
# Called when the node enters the scene tree for the first time.
func _ready():
	_anim_player.play_backwards("Fade") #fade from black to transparent
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition_to(next_scene_path):
	_anim_player.play("Fade") #Fade from transparent to black
	await _anim_player.animation_finished #wait till animation complete: screen is definitely black
	get_tree().change_scene(next_scene_path) #load next scene
	pass
