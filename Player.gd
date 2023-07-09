extends CharacterBody2D
# Set variables and signals
@export_enum("Base", "Robot", "Collected") var state: String = "Base"
@export var speed: float = 100
var screen_size
var collectable
var laser_usable = false
signal hit
signal laser_hit
var animation_set = "1-"

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
	if laser_usable == true:
		if Input.is_action_pressed("shoot"):
			# TODO Fire the laser
			# Get the direction based on velocity
			if velocity.x != 0:
				$AnimatedSprite2D.play("charge_laser_side")
				$AnimatedSprite2D.flip_h = velocity.x > 0
				$AnimatedSprite2D.play("fire_laser_side")
			if velocity.y < 0:
				$AnimatedSprite2D.play("charge_laser_up")
				$AnimatedSprite2D.play("fire_laser_up")
			if velocity.y > 0:
				$AnimatedSprite2D.play("charge_laser_down")
				$AnimatedSprite2D.play("fire_laser_down")
					
				
				
			
			
	

func _physics_process(delta):
	if state == "Base": animation_set = "1-"
	if state == "Robot": animation_set = "2-"
	get_input()
	var collision = move_and_slide()
	if collision:
		velocity = Vector2.ZERO
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play(animation_set + "idle")
		$AnimatedSprite2D.flip_h = false

#	# Handle which animation to play based on current movement
	if velocity.x != 0:
		$AnimatedSprite2D.play(animation_set + "side")
		$AnimatedSprite2D.flip_h = velocity.x > 0

	if velocity.y < 0:
		$AnimatedSprite2D.play(animation_set + "up")

	if velocity.y > 0:
		$AnimatedSprite2D.play(animation_set + "down")
		
func robot_activation():
	# change player state to robot
	state = "Robot"
	# set the laser firable and collectable variables
	laser_usable = true
	collectable = false
	
	# change collision to fit robot size

	



	

	



func _on_deactivated_robot_activated():
	robot_activation()
