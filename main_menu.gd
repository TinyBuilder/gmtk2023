extends CanvasLayer
signal start_new_game
@onready var _transition_rect := $SceneChange
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game(): #on pushing newgame
	$StartGame.hide() #hide buttons
	$CreditsButton.hide()
	#need to add transition to new scene
	start_new_game.emit()
	pass

func _on_credits_pressed():
	$SceneChange._anim_player.play()
	await $SceneChange._anim_player.animation_finished
	$SceneChange._anim_player.play_backwards()
	get_tree().change_scene_to_file("res://Menus/credits.tscn")
	pass # Replace with function body.


func _on_start_new_game():
	$SceneChange._anim_player.play()
	await $SceneChange._anim_player.animation_finished
	$SceneChange._anim_player.play_backwards()
	get_tree().change_scene_to_file("res://Map.tscn")
	pass # Replace with function body.
