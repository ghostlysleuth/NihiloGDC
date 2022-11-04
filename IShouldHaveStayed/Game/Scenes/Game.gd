extends Node3D

var lives := 3
var score := 0
var wallPhase := 0 #Keeps track of what phase the player is on

# Called when the node enters the scene tree for the first time.
func _ready():
    score = 0
    randomize() #Randomizes game seed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func fishGotCaught(fishType):
    score += fishType.WEIGHT
    $CanvasLayer/ScoreLabel.text = "Score: " + str(score)
    if (fishType.DAMAGE >= 1):
        lives -= fishType.DAMAGE
        $CanvasLayer/LifeLabel.text = "Lives: " + str(lives)
    if ((score >= 1) && (wallPhase == 0)):
        wallPhase = 1
        $river/banks/left/bounds.move()
        $river/banks/right/bounds.move()


func createFish(fish):
    var realFish = fish.instantiate()
    realFish.position = $Spawner.position
    call_deferred("add_child", realFish)
    realFish.caught.connect(fishGotCaught)
