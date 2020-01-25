extends TextureRect

export(float) var scroll_speed = 4
func _ready():
	self.material.set_shader_param("scroll_speed", scroll_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass