extends Node3D

var score := 0
var wallPhase := 0 #Keeps track of what phase the player is on

# Called when the node enters the scene tree for the first time.
func _ready():
    score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func fishGotCaught(fishType):
    score += fishType.WEIGHT
    $CanvasLayer/Label.text = "Score: " + str(score)
    if ((score >= 1) && (wallPhase == 0)):
        wallPhase = 1
        $river/banks/left/bounds.move()
        $river/banks/right/bounds.move()
