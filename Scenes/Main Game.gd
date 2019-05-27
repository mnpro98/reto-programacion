extends Node2D

export (NodePath) var player;
onready var _enemyPrefab = preload("res://Scenes/Enemy.tscn")
onready var enemy_container = get_node("enemy_container")
export (int) var enemyCount = 10

# Called when the node enters the scene tree for the first time.
func _ready():
#	get_tree().paused = true
	GLOBAL.score = 0
	GLOBAL.enemyCount = enemyCount
	spawn_enemies(enemyCount)
#	var timer = Timer.new()
#	timer.set_one_shot(true)
#	timer.set_wait_time(3)
#	timer.connect("timeout", self, "on_timeout_complete")
#	add_child(timer)
#	timer.start()
	set_process(true)
#
#func on_timeout_complete():
#	get_tree().paused = false
	
# Para spawnear enemigos
func spawn_enemies(num):
	for i in range(num):
		var e = _enemyPrefab.instance()
		enemy_container.add_child(e)
		e.set_position(Vector2(rand_range(0, 1000),
		                       rand_range(0, 600)))

# Para que los enemigos sigan al jugador y determinar su velocidad
func _process(delta):
	var enemies = enemy_container.get_children()
	for N in enemies:
		var pPosition = get_node(player).get_position()
		var ePosition = N.get_position()
		N.look_at(pPosition)
		var vecDif = pPosition - ePosition
		if(vecDif.x != 0):
			var angle = tanh(vecDif.y/vecDif.x)
			if(pPosition.x > ePosition.x):
				N.move_and_slide(50*Vector2(cos(angle),sin(angle)))
			else:
				N.move_and_slide(-50*Vector2(cos(angle),sin(angle)))

func _exit_tree():
	enemy_container.free()