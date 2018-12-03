extends SceneTree

class ExtendsNode2D:
	extends Node2D

	func my_function():
		return 7

	func get_position():
		return Vector2(0, 0)

class SimpleObject:
	var a = 'a'

func get_methods_by_flag(obj):
	var methods_by_flags = {}
	var methods = obj.get_method_list()

	for i in range(methods.size()):
		var flag = methods[i]['flags']
		var name = methods[i]['name']
		if(methods_by_flags.has(flag)):
			methods_by_flags[flag].append(name)
		else:
			methods_by_flags[flag] = [name]
	return methods_by_flags

func print_methods_by_flags(methods_by_flags):

	for flag in methods_by_flags:
		for i in range(methods_by_flags[flag].size()):
			print(flag, ":  ", methods_by_flags[flag][i])

	var total = 0
	for flag in methods_by_flags:
		if(methods_by_flags[flag].size() > 0):
			print("-- ", flag, " (", methods_by_flags[flag].size(), ") --")
			total += methods_by_flags[flag].size()
	print("Total:  ", total)

func subtract_dictionary(sub_this, from_this):
	var result = {}
	for key in sub_this:
		if(from_this.has(key)):
			result[key] = []

			for value in from_this[key]:
				var index = sub_this[key].find(value)
				if(index == -1):
					result[key].append(value)
	return result

func print_method_info(obj):
	var methods = obj.get_method_list()

	for i in range(methods.size()):
		print(methods[i]['name'])
		for key in methods[i]:
			if(key == 'args'):
				print('  args:')
				for argname in range(methods[i][key].size()):
					print('    ',  methods[i][key][argname]['name'], ':  ', methods[i][key][argname])
			else:
				print('  ', key, ':  ', methods[i][key])

func print_a_bunch_of_methods_by_flags():
	var e = ExtendsNode2D.new()
	var n = get_methods_by_flag(e)
	# print_methods_by_flags(n)

	var s = SimpleObject.new()
	var o = get_methods_by_flag(s)
	# print_methods_by_flags(o)

	#print_methods_by_flags(subtract_dictionary(n, o))
	print("\n\n\n")
	print_methods_by_flags(subtract_dictionary(o, n))
	print("strays  ")
	e.print_stray_nodes()

func _init():
	print_a_bunch_of_methods_by_flags()
	var obj = ExtendsNode2D.new()
	print_method_info(obj)

	quit()