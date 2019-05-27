#Código para el personaje

extends KinematicBody2D

export (int) var maxHealth = 200;
export (int) var speed = 200;
export (NodePath) var _shootPoint;
export (NodePath) var hBar
export (PackedScene) var _bulletPrefab;

var velocity = Vector2();
var Mouse_Position;
var currHealth
var healthPercentage = float(1)
var player

func _ready():
	#Llamado cada vez que el nodo es agregado a la escena
	#Inicialización
	currHealth = maxHealth
	GLOBAL.playerDead = false
	set_physics_process(true)
	
	# Audio
	player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://SFX/Gun (mini).wav")
	player.set_volume_db(-15)

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

func _physics_process(delta):
	# Para el health
	healthPercentage = float(currHealth)/maxHealth

	#Para la rotación y movimiento del personaje
	Mouse_Position = get_local_mouse_position();
	rotation += Mouse_Position.angle();
	get_input();
	velocity = move_and_slide(velocity);
	
	#Para cuando disparas
	var bullet = null;
	if(Input.is_action_pressed("left_click")):
		player.play()
		bullet=_bulletPrefab.instance();
		var node = get_tree().get_root();
		node.add_child(bullet);
		bullet.start_at(get_rotation() - 1.57,get_node(_shootPoint).get_global_position());

# Si te dispara una bala
func _on_Player_area_entered(area):
	if(area.get_name() == "eBullet"):
		currHealth -= 20
		get_node(hBar).margin_right = 520 + 442*healthPercentage
		
		# Si mueres
		if(currHealth <= 0):
			get_node(hBar).margin_right = 520
			GLOBAL.playerDead = true
			get_tree().change_scene("res://Scenes/Lose.tscn")
