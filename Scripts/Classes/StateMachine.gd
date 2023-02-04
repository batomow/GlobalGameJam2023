extends Node

class_name StateMachine

@export var states:Array[GDScript] = []
@export var entity:Node = null

var state_map:Dictionary = {}
var state_stack:Array[State] = []
var current_state = null

func _ready(): 
	for state in states: 
		var file_name = Utils.get_resource_name(state as Resource)
		var new_state:State = state.new(entity, push_state, pop_state)
		state_map[file_name] = new_state
		if not current_state: 
			push_state(file_name)

func push_state(state_name:String): 
	assert(state_name in state_map)
	if current_state: 
		current_state.exit()
		state_stack.push_back(current_state)
	var new_state = state_map[state_name]
	new_state.enter() 
	current_state = new_state

func pop_state(): 
	current_state.exit()
	var past_state = state_stack.pop_front() 
	if past_state: 
		past_state.enter() 
	current_state = past_state

func _process(delta):
	if current_state:
		current_state.handle_process(delta)

func _physics_process(delta):
	if current_state: 
		current_state.handle_physics_process(delta)

func _unhandled_input(event):
	if current_state: 
		current_state.handle_unhandled_input(event)
