extends Node

func dist_sum(total,length):
	var res = []
	for i in range(length):
    	res.append(0)
	for time in range(total):
		var i = randi()%(length)
		res[i] = res[i] + 1
	return res
	