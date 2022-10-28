extends RigidBody3D

#cant find a way for multi line comments
#var summary = """a
#	'spawns' a random object using the list of resource paths. prefills the 'res://'. dosent bother with the leaf
#	objs' appear on a random point within the range. see -> '_ready()' & $range
#
#	-is toggleable
#	-has a random time delay(seconds) between spawns
#
#	starting
#		enabled -> true - starts immideatly
#		startSpawning( initialDelay:float) - starts spawning coroutine, possiable delay. negative delay for random
#
#	stopping
#		enabled -> false - will spawn 1 last one
#		stopImmideatly - self explaining
#
#	-idk how to have variables be set through the inspeactor like unity so no that.
#"""
#GDScript ide sucks. what do you mean I have to learn 100+ unlisted & hidden functions that the script inhearates to do anyhting

signal spawn_fish(fish)

#paths to fish resource
const toSpawn = ["Game/Scenes/one_pounder.tscn"] #full path would be "res://assets/prefab/Box.tscn"
const SPEED := 5

#time
var spawnTime_min : float = 0.5;
var spawnTime_max : float = 1;

#position
@export var range : Vector3
@export var rot : Quaternion

var _enabled : bool = true
var enabled:bool:
    get: return _enabled
    set(v):
        _enabled = v
        if v:
            startSpawning(0)

var _stopImmediately : bool = false;

func _ready():
    #Set velocity so the spawner moves around
    linear_velocity = Vector3(SPEED, 0, 0)
    
    #range = $range.position - position #child node for easy visualization, couldnt find anything built in
    print("hello")
    for i in range(0, toSpawn.size()):
        toSpawn[i] =  'res://' + toSpawn[i]
    print(enabled)
    
    if enabled:
        startSpawning(-1)

func spawnFish(fish):
    emit_signal("spawn_fish", fish)

func startSpawning(initialDelay : float):
    _stopImmediately = false;
    
    var rando = RandomNumberGenerator.new()
    var delay : float = 0
    
    if initialDelay < 0: delay = rando.randi_range(spawnTime_min, spawnTime_max)
    
    while _enabled:
        print(delay)
        await get_tree().create_timer(delay).timeout
        if _stopImmediately: return
        var obj = load(toSpawn[rando.randi_range(0, toSpawn.size()-1)])
        spawnFish(obj)
        #actualObject do stuff

func stopSpawning(stopImmediately : bool):
    enabled = false
    
    #cant find anyhting like StopCoroutine(...) from unity
    _stopImmediately = stopImmediately

func random_vec3(v : Vector3):
    var r = RandomNumberGenerator.new()
    return Vector3(r.randi_range(0, v.x), r.randi_range(0, v.y), r.randi_range(0, v.z))
