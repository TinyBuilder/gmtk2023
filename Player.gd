extends CharacterBody2D
# Set variables and signals
var speed = 400
var screen_size
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):		
		velocity.y -= 1
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1
	

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	# Input mapping
#	if Input.is_action_pressed("move_up"):
#		velocity.y -= 1
#	elif Input.is_action_pressed("move_down"):
#		velocity.y += 1
#	elif Input.is_action_pressed("move_left"):
#		velocity.x -= 1
#	elif Input.is_action_pressed("move_right"):
#		velocity.x += 1
#
#	# Updating player speed, plays animation if moving
#	if velocity.length() > 0:
#		$AnimatedSprite2D.play()
#
#	# If not moving - play an idle animation
#	else:
#		$AnimatedSprite2D.play("idle")
#
#	# Handle which animation to play based on current movement
#	if velocity.x != 0:
#		$AnimatedSprite2D.animation = "move_left"
#		$AnimatedSprite2D.flip_h = velocity.x > 0
#
#	if velocity.y < 0:
#		$AnimatedSprite2D.animation = "move_up"
#
#	if velocity.y > 0:
#		$AnimatedSprite2D.animation = "move_down"

	# Update player position


	

	

