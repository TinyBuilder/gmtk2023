extends Area2D
# Set variables
@export var speed = 400
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO: Player movement - Four directional movement no diagonals
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
		
	if velocity.length() > 0:
		velocity = velocity * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# Update player position
	position += velocity * delta

