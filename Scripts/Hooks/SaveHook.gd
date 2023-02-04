extends Hook

class_name SaveHook

#Save file example
#{
#	"enemy": { 
#		"la234-aslk": { ... }
#	}, 
#	"object": {
#		"asl81-q234": { ... }
#	}
#}

var _current_file_name = ""
var _get_save_objects: Callable

signal overriding_save(file_name)
signal have_not_saved_yet()


func _init(get_save_objects_method:Callable ):
	super() 
	_get_save_objects = get_save_objects_method

func _collect_save_data(): 
	var save_objects = _get_save_objects.call()
	var collected_data = []
	for object in save_objects: 
		assert(object.has_method("get_save_data"))
		var save_data = object.get_save_data()
		collected_data.push_back(save_data)
	return collected_data


func _save(): 
	var collected_data = _collect_save_data()
	var save_data = {}
	for datum in collected_data: 
		assert("type" in datum)
		assert("uuid" in datum)
		var type = datum["type"]
		var uuid = datum["uuid"]
		if not type in save_data: 
			save_data[type] = {}
		datum.erase(type) #remove redudant data
		datum.erase(uuid) #remove redundant data
		save_data[type][uuid] = datum
	SaveService.save_data(_current_file_name, save_data)

#returns Error
func create_new_save(file_name:String)->int: 
	var saves = SaveService.get_save_file_names()
	if file_name in saves: 
		emit_signal("overriding_save", file_name)
		return FAILED
	_current_file_name = file_name
	_save()
	return OK

#return Error
func save_game()->int: 
	if _current_file_name.is_empty():
		emit_signal("have_not_saved_yet")
		return FAILED
	_save() 
	return OK

func get_current_save_file_name()->String: 
	return _current_file_name

func exports()->Array[Callable]: 
	return [ 
		create_new_save, 
		save_game, 
		get_current_save_file_name
	]
