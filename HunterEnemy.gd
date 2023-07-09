extends CharacterBody2D

@export_enum("Idle", "Pursuit", "Rush") var state: String = "Idle"
@export_enum("Knight", "NotLink", "Cleric") var enemy_type: String = "Cleric"
@export var direction: float = 0 ##angle in radians
@export var speed: float = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	$LightOccluder2D.set_rotation(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func patrol():
	state = "Idle"
	if enemy_type == "Cleric":
		velocity = Vector2.ZERO
		direction += 0.05
	
func _physics_process(delta):
	var target_position = $"../player".get_position()
	var target_vector_normalized = (target_position - get_position()).normalized()
	
	if state == "Rush":
		# rush player
		return
	
	if !Geometry2D.is_point_in_polygon(target_vector_normalized.rotated(-direction), $LightOccluder2D.occluder.polygon) :
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, $"../player".global_position, collision_mask)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result["collider"] == $"../player" :
			state = "Pursuit"
			velocity = speed * target_vector_normalized
			direction = target_vector_normalized.angle() - PI/2
		else:
			patrol()
	else:
		patrol()
	
	if direction > PI: direction -= 2 * PI
	if direction < -PI: direction += 2 * PI
	
	$LightOccluder2D.set_rotation(direction)
	move_and_slide()
	
	
