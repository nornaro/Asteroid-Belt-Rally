extends MeshInstance3D

var inner_radius := 10.0
var outer_radius := 20.0
var segments := 100

func _ready():
	var array_mesh := ArrayMesh.new()
	var arrays := []
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()

	for i in range(segments):
		var angle1 := i * 2 * PI / segments
		var angle2 := (i + 1) * 2 * PI / segments

		var inner_x1 := cos(angle1) * inner_radius
		var inner_y1 := sin(angle1) * inner_radius
		var inner_x2 := cos(angle2) * inner_radius
		var inner_y2 := sin(angle2) * inner_radius

		var outer_x1 := cos(angle1) * outer_radius
		var outer_y1 := sin(angle1) * outer_radius
		var outer_x2 := cos(angle2) * outer_radius
		var outer_y2 := sin(angle2) * outer_radius

		var v1 := Vector3(inner_x1, 0, inner_y1)
		var v2 := Vector3(outer_x1, 0, outer_y1)
		var v3 := Vector3(outer_x2, 0, outer_y2)
		var v4 := Vector3(inner_x2, 0, inner_y2)

		vertices.push_back(v1)
		vertices.push_back(v2)
		vertices.push_back(v3)
		vertices.push_back(v4)

		var n := i * 4
		indices.push_back(n)
		indices.push_back(n + 1)
		indices.push_back(n + 2)
		indices.push_back(n)
		indices.push_back(n + 2)
		indices.push_back(n + 3)

	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_INDEX] = indices

	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	self.mesh = array_mesh
