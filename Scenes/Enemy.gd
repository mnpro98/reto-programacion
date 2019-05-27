# Script para el enemigo
extends KinematicBody2D

var vel = Vector2()
export (float) var maxHealth = 100;
export (PackedScene) var _bulletPrefab;
var currHealth;
var player

# Timer
var timer = null
var bullet_delay = rand_range(0.5,1)
var can_shoot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Para la latencia de los disparos
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_delay)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
	randomize()
	set_process(true)
	vel = Vector2(rand_range(5000, 6000), 0)
	
	# Health
	currHealth = maxHealth
	
	# Sonido
	player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://SFX/Gun (medium).wav")
	player.set_volume_db(-15)

# Cuando pase el tiempo del timeout
func on_timeout_complete():
	can_shoot = true

func _process(delta):
	# Dispara balas
	var bullet = null;
	if(can_shoot):
		player.play()
		bullet=_bulletPrefab.instance();
		var node = get_tree().get_root();
		node.add_child(bullet);
		bullet.start_at(get_rotation() - 1.57, get_global_position());
		can_shoot = false
		timer.start()
		
	# Si currHealth es 0, el enemigo desaparece y el score aumenta
	if(currHealth <= 0):
		GLOBAL.score += 100
		GLOBAL.enemyCount -= 1
		if GLOBAL.enemyCount <= 0:
			get_tree().change_scene("res://Scenes/Win.tscn")
		get_parent().remove_child(self)

# Si el enemigo toca una bala
func _on_Enemy_area_entered(area):
	if(area.get_name() == "Bullet"):
		currHealth -= 10
		GLOBAL.score += 10

