extends Node2D

func _physics_process(delta):
	if(!Rewind.is_rewinding):
		random_move()
			
var target_pos = Vector2(0,0)
var doing_move = false
func random_move():
	if(!doing_move):
		target_pos = Vector2(rand_range(0,500),rand_range(50,200))
		doing_move = true
	else:
		global_position = global_position.move_toward(target_pos,3)
		if(global_position.distance_to(target_pos) < 1):
			doing_move = false
	if(global_position.x > target_pos.x):
		get_node("AnimatedSprite").flip_h = true
	else:
		get_node("AnimatedSprite").flip_h = false
	pass
