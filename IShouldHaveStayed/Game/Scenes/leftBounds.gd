extends StaticBody3D
var moving := false
var currentWallPhase := 0 #Keeps track of the desired position in move()
var originalPosition := position.x
var desiredPosition := position.x
const SPEED := 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if (moving):
		position.x -= (SPEED * delta)
		if (position.x <= desiredPosition):
			position.x = desiredPosition #In case it goes a bit over
			++currentWallPhase
			moving = false

#Sets desired positon and moving to true, logic is in physic process
func move():
	if (currentWallPhase == 0):
		desiredPosition = (originalPosition - 3)
	
	moving = true
