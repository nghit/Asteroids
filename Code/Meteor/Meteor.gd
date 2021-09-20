extends Area2D
#regular meteor 
export var minSpeed: float = 10
export var maxSpeed: float = 20
export var minRotationRate: float = -25
export var maxRotationRate: float = 25
onready var UI = get_tree().current_scene.get_node("UI")
export var life: int = 20
var speed: float = 0
var rotationRate: float = 0

func _ready():
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)
	
func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.y += speed * delta

func damage(amount: int):
	life -= amount
	if life <= 0:
		UI.increase_score(100)
		queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Meteor_area_entered(area):
	if area.is_in_group("Player"):
		UI.decrease_health()
		queue_free()
