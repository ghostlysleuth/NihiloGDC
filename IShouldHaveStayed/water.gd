extends Node3D

var moving := false
var currentWallPhase := 0 #Keeps track of the desired position in move()
var originalPosition := position.y
var desiredPosition := position.y
const SPEED := 5
signal water_level_updated

# Called when the node enters the scene tree for the first time.
func _ready():
    originalPosition = position.y #Needed, or else originalPosition will be wrong


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _physics_process(delta):
    if (moving):
        emit_signal("water_level_updated", position.y)
        if (desiredPosition < position.y):
            position.y -= (SPEED * delta)
            if (position.y <= desiredPosition):
                position.y = desiredPosition #In case it goes a bit over
                moving = false
                
        else:
            position.y += (SPEED * delta)
            if (position.y >= desiredPosition):
                position.y = desiredPosition #In case it goes a bit over
                moving = false
        

#Sets desired positon and moving to true, logic is in physic process
func move(desiredWallPhase):
    if (desiredWallPhase == 0):
        desiredPosition = originalPosition
        currentWallPhase = desiredWallPhase
    if (desiredWallPhase == 1):
        desiredPosition = (originalPosition + 10)
        currentWallPhase = desiredWallPhase
    
    moving = true
