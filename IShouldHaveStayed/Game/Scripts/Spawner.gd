extends RigidBody3D

signal spawn_fish(fish)
const SPEED := 5

#Paths to fish resource
const eel = preload("res://Game/Scenes/eel.tscn")
const one_pounder = preload("res://Game/Scenes/one_pounder.tscn")
const five_pounder = preload("res://Game/Scenes/five_pounder.tscn")

#Phases
enum Phases 
{
    ALL_ONE_POUNDER,
    ALL_FIVE_POUNDER,
    OOPS_ALL_EELS,
}
var currentPhase := Phases.ALL_ONE_POUNDER
var fishArray := []

var currentlySpawning := true
var timerDone := false

#Time
var timerTime = .5
var spawnTime_min : float = 0.5;
var spawnTime_max : float = 1;

#Position
@export var range : Vector3
@export var rot : Quaternion

func _ready():
    #Set velocity so the spawner moves around
    linear_velocity = Vector3(SPEED, 0, 0)
    $SpawnTimer.start(timerTime)
 
func changePhase():
    currentPhase = randi_range(0, Phases.size()) 
    timerTime = randf_range(0.5, 1)
    match(currentPhase):
        Phases.ALL_ONE_POUNDER:
            fishArray = [one_pounder, one_pounder, one_pounder, one_pounder, one_pounder]
        Phases.ALL_FIVE_POUNDER:
            fishArray = [five_pounder, five_pounder, five_pounder, five_pounder, five_pounder]
        Phases.OOPS_ALL_EELS:
            fishArray = [eel, eel, eel, eel, eel]
            timerTime = randf_range(0.4, 0.5)
        _:
            fishArray.clear() #Failsafe

func _physics_process(delta):
    if !timerDone:
        return
    else:
        if (fishArray.size() > 0):
            spawnFishFromArray()
        else:
            changePhase()
            #spawnFishFromArray() #Uncomment if you don't want the gap
        $SpawnTimer.start(timerTime)
        timerDone = false

#fish in this context is a preloaded scene
func spawnFish(fish):
    emit_signal("spawn_fish", fish)

#Spawns random fish from array
func spawnFishFromArray():
    spawnFish(fishArray.pop_at(randi_range(0, fishArray.size() - 1))) #Replace with random number

func random_vec3(v : Vector3):
    var r = RandomNumberGenerator.new()
    return Vector3(r.randi_range(0, v.x), r.randi_range(0, v.y), r.randi_range(0, v.z))


func _on_spawn_timer_timeout():
    timerDone = true
