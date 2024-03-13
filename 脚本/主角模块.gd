extends CharacterBody2D


enum player_state{
	MOVE,
	SWORD,
	JUMP,
	DEAD
}



@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_tree_state = animation_tree.get("parameters/playback")

var speed = 200
var current_state = player_state.MOVE


func _ready() -> void:
	collision_shape_2d.disabled = true
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	match current_state:
			player_state.MOVE:
				move()
			player_state.SWORD:
				sword()
				pass
func move():
	var direction = Input.get_vector("ui_left" , "ui_right" ,"ui_up" ,"ui_down")
	velocity = direction * speed
	if direction:
		animation_tree.set("parameters/idle/blend_position" , direction)
		animation_tree.set("parameters/jump/blend_position" , direction)
		animation_tree.set("parameters/sword/blend_position" , direction)
		animation_tree.set("parameters/walk/blend_position" , direction)
		animation_tree_state.travel("walk")
	else:
		animation_tree_state.travel("idle") 
	if Input.is_action_just_pressed("sword"):
		current_state = player_state.SWORD
		#animation_tree_state.travel("sword")
	move_and_slide()
func sword():
	animation_tree_state.travel("sword")
func on_state_reset():
	current_state = player_state.MOVE
	
