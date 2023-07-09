extends CharacterBody2D

var state
var type
# Called when the node enters the scene tree for the first time.
func _ready():
	state = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var target_position = $"../player".get_position()
	var target_vector_normalized = (target_position - get_position()).normalized()
	
	if Geometry2D.is_point_in_polygon(target_vector_normalized, $LightOccluder2D.occluder.polygon) :
		return
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, $"../player".global_position, collision_mask)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result["collider"] == $"../player" :
		print("spotted")

