extends Node2D

var target_pos = Vector2(0,0)
var doing_move = false

#get a random position, and then move rat there, once there, change the random position
func random_move():
	if(!doing_move): #update the position
		target_pos = Vector2(rand_range(0,500),global_position.y)
		doing_move = true
	else: # move to position
		global_position = global_position.move_toward(target_pos,3)
		if(global_position.distance_to(target_pos) < 1): # position reached
			doing_move = false
			
	#Make sure the rat is facing the direction of it's movement
	if(global_position.x > target_pos.x):
		get_node("AnimatedSprite").flip_h = true
	else:
		get_node("AnimatedSprite").flip_h = false
	pass
	
func _physics_process(delta):
	if(!Rewind.is_rewinding):
		random_move()
