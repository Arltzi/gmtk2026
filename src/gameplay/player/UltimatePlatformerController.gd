class_name PlatformerController2D extends CharacterBody2D

@export_category("Movement")
@export var speed: float = 300.0
@export var acceleration: float = 2000.0
@export var friction: float = 2000.0

@export_category("Jumping")
@export var jump_force: float = -400.0
@export var base_gravity: float = 900.0
@export var fall_gravity_multiplier: float = 1.5
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1

@export_category("Wall Jump")
@export var wall_slide_speed: float = 100.0
@export var wall_jump_velocity: Vector2 = Vector2(400, -350)
@export var wall_jump_control_loss: float = 0.2

@export_category("Corner Correction")
@export var corner_push_amount: float = 2.0
## Place these RayCast2Ds at the top-left and top-right of your player, pointing UP.
@export var ray_top_left: RayCast2D
@export var ray_top_right: RayCast2D

var _coyote_timer: float = 0.0
var _jump_buffer_timer: float = 0.0
var _wall_jump_timer: float = 0.0

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_axis("left", "right")

	_update_timers(delta)
	_apply_gravity_and_wall_slide(input_dir, delta)
	_handle_jumping()
	_handle_movement(input_dir, delta)
	_handle_corner_correction()

	move_and_slide()

func _update_timers(delta: float) -> void:
	if is_on_floor():
		_coyote_timer = coyote_time
	else:
		_coyote_timer -= delta

	_jump_buffer_timer -= delta
	_wall_jump_timer -= delta

	if Input.is_action_just_pressed("jump"):
		_jump_buffer_timer = jump_buffer_time

func _apply_gravity_and_wall_slide(input_dir: float, delta: float) -> void:
	if not is_on_floor():
		# Apply heavier gravity when falling for a tighter feel
		var current_grav = base_gravity * (fall_gravity_multiplier if velocity.y > 0 else 1.0)
		velocity.y += current_grav * delta

		# Wall sliding: if falling, touching wall, and holding input toward the wall
		if is_on_wall() and velocity.y > 0 and input_dir == get_wall_normal().x * -1:
			velocity.y = min(velocity.y, wall_slide_speed)

func _handle_jumping() -> void:
	# Execute Jump (checks buffer)
	if _jump_buffer_timer > 0.0:
		if _coyote_timer > 0.0:
			_perform_jump()
		elif is_on_wall() and not is_on_floor():
			_perform_wall_jump()

	# Variable Jump Height (Short Hop)
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5 # Cuts vertical speed in half if jump is released early

func _perform_jump() -> void:
	velocity.y = jump_force
	_jump_buffer_timer = 0.0
	_coyote_timer = 0.0

func _perform_wall_jump() -> void:
	var wall_normal := get_wall_normal()
	velocity.x = wall_normal.x * wall_jump_velocity.x
	velocity.y = wall_jump_velocity.y
	_jump_buffer_timer = 0.0
	_wall_jump_timer = wall_jump_control_loss # Pauses player input briefly so they don't instantly snap back to the wall

func _handle_movement(input_dir: float, delta: float) -> void:
	# Only allow horizontal control if we aren't locked in a wall jump bounce
	if _wall_jump_timer <= 0.0:
		if input_dir != 0:
			velocity.x = move_toward(velocity.x, input_dir * speed, acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, friction * delta)

func _handle_corner_correction() -> void:
	# Only correct when moving upwards
	if velocity.y >= 0 or not (ray_top_left and ray_top_right):
		return

	var left_hit := ray_top_left.is_colliding()
	var right_hit := ray_top_right.is_colliding()

	# Nudge player horizontally if they clip a corner slightly
	if left_hit and not right_hit:
		position.x += corner_push_amount
	elif right_hit and not left_hit:
		position.x -= corner_push_amount
