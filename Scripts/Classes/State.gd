extends RefCounted

class_name State

var entity:Node = null
var _push:Callable
var _pop:Callable 

func push_state(state_name): 
	assert(_push.is_valid())
	_push.call(state_name)

func pop_state(): 
	assert(_pop.is_valid())
	_pop.call()

func _init(entity_reference:Node, push:Callable, pop:Callable): 
	entity = entity_reference
	_push = push
	_pop = pop

func enter(): 
	pass

func handle_unhandled_input(): 
	pass

func handle_process(__): 
	pass

func handle_physics_process(__): 
	pass

func exit(__): 
	pass


