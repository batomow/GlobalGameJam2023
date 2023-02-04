extends RefCounted

class_name SaveService

const PATH = "user://"
const EXTENSION = ".save"

static func save_data(file_name:String, data:Dictionary):
	var full_path = "".join([PATH, file_name, EXTENSION])
	var file = FileAccess.open(full_path, FileAccess.WRITE)
	var json = JSON.new()
	var json_string:String = json.stringify(data)
	var res = json.parse(json_string)
	if res != OK: 
		printerr(" ".join(["Invalid json data!: ", res.get_error_line(), ":", res.get_error_message()]))
		return null
	file.store_line(json_string)

static func load_data(file_name:String): 
	if not FileAccess.file_exists("".join([PATH, file_name, EXTENSION])): 
		printerr(" ".join(["File doest exists:", file_name]))
		return null
	var file = FileAccess.open("/".join([PATH< file_name, EXTENSION]), FileAccess.READ)
	var json_string = file.get_line() 
	var json = JSON.new() 
	var res = json.parse(json_string) #apparently it assigns the json.data varibale 
	if res != OK: 
		printerr(" ".join(["Invalid json data!: ", res.get_error_line(), ":", res.get_error_message()]))
		return null
	return json.data

static func get_save_file_names(): 
	return DirAccess.get_files_at(PATH)
