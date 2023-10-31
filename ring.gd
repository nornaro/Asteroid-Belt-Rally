extends Node

var asteroid_scene = preload("res://asteroid.tscn")
var total_asteroids = 1000
var asteroids_per_frame = 100
var created_asteroids = 0

func _ready():
	set_process(true)

func _process(delta):
	if created_asteroids < total_asteroids:
		for _i in range(asteroids_per_frame):
			if created_asteroids >= total_asteroids:
				break
			spawn_asteroid()
			created_asteroids += 1

func spawn_asteroid():
	var distance = randi_range(1500, 3000)
	var angle = randf() * 2 * PI
	var x = cos(angle) * distance
	var z = sin(angle) * distance
	var height_limit = map_value(distance, 1500, 3000, 750, 50)
	var y = randi_range(-height_limit, height_limit)

	var asteroid_instance = asteroid_scene.instantiate()
	asteroid_instance.transform.origin = Vector3(x, y, z)
	add_child(asteroid_instance)

func map_value(value, in_min, in_max, out_min, out_max):
	return (value - in_min) / (in_max - in_min) * (out_max - out_min) + out_min
