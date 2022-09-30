extends CharacterBody3D

class_name Fish
@icon("res://fish.svg")

@onready var fishData: Node = $FishData

signal fish_died

const SPEED:float = 5.0
const JUMP_VELOCITY = 4.5

const DIR:Vector3 = Vector3.FORWARD

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
    pass

func _physics_process(delta):
    var direction =  DIR
    velocity = direction * SPEED

    move_and_slide()

