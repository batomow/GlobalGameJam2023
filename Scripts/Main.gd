extends Node

var create_new_save := Callable(self, "create_new_save")
var save_game := Callable(self, "save_game")
var get_save_files = Callable(self, "get_save_files")

func _ready(): 
	var get_save_objects = func ():
		return get_tree().get_nodes_in_group("persistent")
		
	Utils.use([
		create_new_save, 
		save_game, 
		get_save_files
	], SaveHook.new(get_save_objects))
