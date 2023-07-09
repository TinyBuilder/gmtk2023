extends CharacterBody2D
# Set variables and signals
@export_enum("Base", "Robot", "Collected") var state: String = "Base"
@export var speed: float = 400
var screen_size
signal hit
signal laser_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):		
		velocity.y -= speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x += speed
	

func _physics_process(delta):
	get_input()
	var collision = move_and_slide()
	if collision:
		velocity = Vector2.ZERO
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_h = false

#	# Handle which animation to play based on current movement
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "move_left"
		$AnimatedSprite2D.flip_h = velocity.x > 0

	if velocity.y < 0:
		$AnimatedSprite2D.animation = "move_up"

	if velocity.y > 0:
		$AnimatedSprite2D.animation = "move_down"




	

	

