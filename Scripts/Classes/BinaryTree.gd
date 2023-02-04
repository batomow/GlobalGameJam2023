extends RefCounted

class_name BinaryTree

var root = null

func insert(value):
	if root == null:
		root = BinaryTreeNode.new()
		root.value = value
	else:
		_insert(root, value)

func _insert(node, value):
	if value < node.value:
		if node.left == null:
			node.left = BinaryTreeNode.new()
			node.left.value = value
		else:
			_insert(node.left, value)
	else:
		if node.right == null:
			node.right = BinaryTreeNode.new()
			node.right.value = value
		else:
			_insert(node.right, value)

func search(value):
	return _search(root, value)

func _search(node, value):
	if node == null:
		return false
	if node.value == value:
		return true
	if value < node.value:
		return _search(node.left, value)
	else:
		return _search(node.right, value)

func traverse_in_order():
	_traverse_in_order(root)

func _traverse_in_order(node):
	if node == null:
		return
	_traverse_in_order(node.left)
	print(node.value)
	_traverse_in_order(node.right)
