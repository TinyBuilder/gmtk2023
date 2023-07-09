extends CharacterBody2D

@export_enum("Idle", "Pursuit", "Rush", "Dead") var state: String = "Idle"
@export_enum("Knight", "NotLink", "Cleric") var enemy_type: String = "Cleric"
@export var direction: float = 0 ##angle in radians
@export var speed: float = 300
var animation_set = "1-"
var patrol_points
var patrol_target = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$LightOccluder2D.set_rotation(direction)
	if enemy_type == "Knight": animation_set = "2-"
	if enemy_type == "NotLink": animation_set = "3-"
	$AnimatedSprite2D.play(animation_set + "down")
	patrol_points = [Vector2(50, get_position().y), Vector2(206, get_position().y)]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func patrol():
	state = "Idle"
	if enemy_type == "Cleric":
		velocity = Vector2.ZERO
		direction += 0.05
	
	if enemy_type == "Knight":
		if patrol_target == 0 && get_position().x <= 50:
			patrol_target = 1
		if patrol_target == 1 && get_position().x >= 206:
			patrol_target = 0
		
		var target_vector_normalized = (patrol_points[patrol_target] - get_position()).normalized()
		velocity = speed * target_vector_normalized
		direction = target_vector_normalized.angle() - PI/2
	
func _physics_process(delta):
	if state == "Dead": return
	
	var target_position = $"../Player".get_position()
	var target_vector_normalized = (target_position - get_position()).normalized()
	
	if state == "Rush":
		# rush player
		velocity = speed * target_vector_normalized
		direction = target_vector_normalized.angle() - PI/2
	elif !Geometry2D.is_point_in_polygon(target_vector_normalized.rotated(-direction), $LightOccluder2D.occluder.polygon) :
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, $"../Player".global_position, collision_mask)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result["collider"] == $"../Player" :
			state = "Pursuit"
			if enemy_type == "Knight": state = "Rush"
			velocity = speed * target_vector_normalized
			direction = target_vector_normalized.angle() - PI/2
		else:
			patrol()
	else:
		patrol()
	
	if direction > PI: direction -= 2 * PI
	if direction < -PI: direction += 2 * PI
	
	$LightOccluder2D.set_rotation(direction)
	
	if direction > -PI/4 && direction < PI/4: $AnimatedSprite2D.play(animation_set + "down")
	if direction > PI/4 && direction < 3*PI/4: 
		$AnimatedSprite2D.set_flip_h(true)
		$AnimatedSprite2D.play(animation_set + "right")
	if direction > 3*PI/4 || direction < -3*PI/4: $AnimatedSprite2D.play(animation_set + "up")
	if direction > -3*PI/4 && direction < -PI/4:
		$AnimatedSprite2D.set_flip_h(false)
		$AnimatedSprite2D.play(animation_set + "right")
		
	move_and_slide()
	
