extends Sprite

var vel = Vector2()
export (int) var speed = 500
var screenSize = GLOBAL.screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true);

# Para definir la posición y dirección inicial de la bala
func start_at(dir, pos):
	set_rotation(dir);
	set_position(pos);
	vel = Vector2(0, speed).rotated(dir);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	set_position(get_position() + vel * delta);
	if (position.x > screenSize.x || position.y > screenSize.y || position.x < 0 || position.y < 0):
		get_parent().remove_child(self)

# Para que se destruya la bala si toca al enemigo
func _on_Bullet_area_entered(area):
	call_deferred("delete_bullet",area)

func delete_bullet(area):
	if area != null:
		if ("Enemy" in area.get_name()):
			get_parent().remove_child(self)
