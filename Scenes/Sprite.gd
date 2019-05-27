#Código para el personaje

extends Sprite

export (int) var speed = 200;
export (NodePath) var _shootPoint;
export (PackedScene) var _bulletPrefab;

var velocity = Vector2();
var Mouse_Position;
var _bullets=[];

func _ready():
	#Llamado cada vez que el nodo es agregado a la escena
	#Inicialización
	set_process(true);

#get_input es para la traslación del personaje
func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _process(delta):
	#Para la rotación del personaje
	#---------------------------------------------
	Mouse_Position = get_local_mouse_position();
	rotation += Mouse_Position.angle();
	#---------------------------------------------
	get_input();
	velocity = move_and_slide(velocity);
	
	var bullet = null;
	if(Input.is_key_pressed(KEY_Q)):
		print("created new node");
		bullet=_bulletPrefab.instance();
		var node = get_tree().get_root();
		node.add_child(bullet);
		bullet.set_pos(get_node(_shootPoint).get_global_pos());
		_bullets.push_back(bullet);
		
	for bullet in _bullets:
		var newPos = bullet.get_pos();
		newPos += Vector2(800,0)*delta;