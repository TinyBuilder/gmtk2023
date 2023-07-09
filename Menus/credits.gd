extends CanvasLayer
@onready var _transition_rect := $SceneChange

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	$SceneChange._anim_player.play()
	await $SceneChange._anim_player.animation_finished
	$SceneChange._anim_player.play_backwards()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	pass # Replace with function body.
