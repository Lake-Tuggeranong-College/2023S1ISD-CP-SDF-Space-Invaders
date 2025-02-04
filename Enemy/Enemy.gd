extends KinematicBody2D

var bullet = preload("res://Bullet-Enemy/Bullet-Enemy.tscn")
export (int) var health = 1




	
func _ready():
	$Area2D.connect("area_entered", self, "_colliding")
	

func _colliding(area):
	if area.is_in_group("right"):
		#print("emenies collide right")
		get_parent().global_position.y += 10
		get_parent().speed = -100
	if area.is_in_group("left"):
		#print("emenies collide left")
		get_parent().global_position.y += 10
		get_parent().speed = 100


func _process(delta):
	if GlobalVariables.Player == null:
		queue_free()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(2.0, 30.0)
	#print("time: ",my_random_number)
	yield(get_tree().create_timer(my_random_number), "timeout")
	if GlobalVariables.enemyBulletInstanceCount < 5:
		var bulletInstance = bullet.instance()
		
		bulletInstance.position = Vector2(global_position.x, global_position.y+20)
		get_tree().get_root().add_child(bulletInstance)

func reduceHealth():
	health -=1
	if health == 0:
		queue_free()
