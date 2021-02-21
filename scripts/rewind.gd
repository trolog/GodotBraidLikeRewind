extends Node

var is_rewinding = false # we'll use this to disable this object when true. so we can add recorded data to it
var rewind_length = (60 * 3) # 180 this is 3seconds running at 60fps
var count = 0;# used to determine where we are in array
var DATA = [] # this will store all our data on any rewind objects
var rewind_objects #this will keep track of objects that we rewind

var rewind_ghost = load("res://objects/rewind_ghost.tscn")

func _ready():
	rewind_objects = get_tree().get_nodes_in_group("rewind")
	for mem in rewind_objects:
		DATA.push_back([mem.name])
		
func handle_rewind_objects():
	if(Input.is_action_pressed("b_button")):
		is_rewinding = true
		for mem in rewind_objects:
			var data = DATA[count]
			if(data.size() > 1):
				var current_frame = data[0]
				var ani = mem.get_node("AnimatedSprite")
				
				#Set our objects animation/position/direciton
				ani.animation = current_frame[0]
				mem.global_position = current_frame[1]
				ani.flip_h = current_frame[2]
				
				#Do the ghost functionality
				var ghost : Sprite = rewind_ghost.instance()
				ghost.texture = ani.frames.get_frame(ani.animation,ani.frame)
				ghost.global_position = mem.global_position
				ghost.flip_h = ani.flip_h
				get_parent().add_child(ghost)
				
				#remove thet first frame as we've just used it
				data.pop_front()
				count += 1
		count = 0
	else:# Record all objects in our rewind group
		is_rewinding = false
		for mem in rewind_objects:
			var data = DATA[count]
			var ani = mem.get_node("AnimatedSprite")
			data.push_front([ani.animation,mem.global_position,ani.flip_h])
			count += 1
			if(data.size() > rewind_length): #our record is longer than 3 secs, remove last frame
				data.pop_back()
		count = 0
		pass
		
func _physics_process(delta):
	handle_rewind_objects()
