extends RefCounted

class_name Utils

static func use(setters:Array[Callable], hook:Hook): 
	var exports = hook.exports()
	for i in range(min(exports.size(), setters.size())): 
		var next_setter = setters[i]
		var next_export = exports[i]
		var object = next_setter.get_object()
		var method = next_setter.get_method()
		object[method] = next_export

static func get_file_name_raw(file_path:String)->String: 
	var file:String = file_path.get_file() 
	var name:String = file.get_slice(".", 0)
	return name

static func get_file_name(file_path:String)->String: 
	var name:String = get_file_name_raw(file_path)
	var snake_case_name:String = name.to_snake_case()
	return snake_case_name

static func get_resource_name_raw(resource:Resource)->String: 
	var file_path:String = resource.resource_path
	var file:String = file_path.get_file()
	var name:String = file.get_slice(".", 0)
	return name

static func get_resource_name(resource:Resource)->String: 
	var name:String = get_resource_name_raw(resource)
	var snake_case_name:String = name.to_snake_case()
	return snake_case_name
