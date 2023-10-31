extends Node3D

@export var arm_length: float = 10.0
@export var rotation_speed: float = 0.001

#func _physics_process(delta: float) -> void:
#	rotation = Vector3(lerp(get_parent().rotation.x, rotation.x, rotation_speed * delta), lerp(get_parent().rotation.y, rotation.y, rotation_speed * delta) - 180, lerp(get_parent().rotation.z, rotation.z, rotation_speed * delta))

