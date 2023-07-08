extends Area2D
# Set variables and signals
@export var speed = 400
var velocity
var screen_size
signal hit




# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	# Input mapping
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	# Updating player speed, plays animation if moving
	if velocity.length() > 0:
		velocity = velocity * speed
		$AnimatedSprite2D.play()
	
	# If not moving - play an idle animation
	else:
		$AnimatedSprite2D.play("Idle_animation")
	
	# Handle which animation to play based on current movement
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "move_side"
		$AnimatedSprite2D.flip_h = velocity.x > 0
	
	if velocity.y < 0:
		$AnimatedSprite2D.animation = "move_up"
	
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "move_down"

	# Update player position
	position += velocity * delta
	

	

