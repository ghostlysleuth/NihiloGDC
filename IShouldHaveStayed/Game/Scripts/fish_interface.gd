extends CharacterBody3D

class_name Fish
@icon("res://fish.svg")

@onready var fishData: Node = $FishData

signal caught(fishType)

var current:Vector3 = Vector3.BACK


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
    velocity = current*fishData.SPEED
    add_to_group("fish")

func _process(delta):
    pass

func _physics_process(delta):
    move_and_slide()

func _on_hitbox_area_entered(area):
    emit_signal("caught", fishData)
    queue_free()

func _on_despawn_hitbox_area_entered(area):
    queue_free()
