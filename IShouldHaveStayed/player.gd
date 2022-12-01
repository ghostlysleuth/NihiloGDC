extends CharacterBody3D


@export var SPEED = 10.0


func _physics_process(delta):
    var direction = Vector3.ZERO
    
    #Get direction
    if Input.is_action_pressed("move_left"):
        direction.x -= 1
    if Input.is_action_pressed("move_right"):
        direction.x += 1
    if direction != Vector3.ZERO:
        direction = direction.normalized()
    #Implement speed
    if Input.is_action_pressed("focus"):
        velocity.x = direction.x * (SPEED / 2)
    else:
        velocity.x = direction.x * SPEED
    
    #Move
    move_and_slide()
    

func _on_hitbox_area_entered(area):
    print("Player hitbox entered") #Replace with animiation
    
func waterLevelUpdated(waterPosition):
    position.y = waterPosition
