extends CanvasLayer
signal start_new_game
var credits_on = 0 #used for toggling credits text
@onready var _transition_rect := $SceneChange
# Called when the node enters the scene tree for the first time.
func _ready():
	$CreditsText.hide() #ensures credits text hidden by default
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

func show_game_won():
	$StartGame.text = "Congratulations, you escaped! Want to play again?" #updates start button text
	$StartGame.show() #re-reveals start button
	pass
	
func show_game_over():
	$StartGame.text = "Try Again?" #updates start button text
	$StartGame.show() #re-reveals start button
	
	pass

func _on_credits_pressed():
	if credits_on == 0:
		$StartGame.hide()
		$CreditsButton.text = "Hide Credits" #Updates button text
		$CreditsText.show()
		$Logo.set_modulate(Color (1,1,1,0.1)) #Dims background while credits display
		credits_on = 1
	else: 
		$StartGame.show()
		$CreditsText.hide()
		$Logo.set_modulate(Color (1,1,1,1)) #relightens background
		$CreditsButton.text = "Show Credits"
		credits_on = 0
	pass # Replace with function body.



func _on_start_new_game():
	$SceneChange._anim_player.play()
	$Logo.hide()
	$SceneChange._anim_player.play_backwards()
	pass # Replace with function body.
