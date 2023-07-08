extends CanvasLayer
signal start_new_game
var credits_on = 0 #used for toggling credits text

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
	pass

func game_won():
	$StartGame.text = "Congratulations, you escaped! Want to play again?" #updates start button text
	$StartGame.show() #re-reveals start button
	pass
	
func game_lost():
	$StartGame.text = "Try Again?" #updates start button text
	$StartGame.show() #re-reveals start button
	
	pass

func _on_credits_pressed():
	if credits_on == 0:
		$StartGame.hide()
		$CreditsButton.text = "Hide Credits"
		$CreditsText.show()
		credits_on = 1
	else: 
		$StartGame.show()
		$CreditsText.hide()
		$CreditsButton.text = "Show Credits"
		credits_on = 0
	pass # Replace with function body.
