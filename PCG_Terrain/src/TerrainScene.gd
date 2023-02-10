extends Node2D

export var width := 275
export var height := 200
export var octaves := 5
export var textureCount := 4
onready var tileMap := $TileMap

var noise := OpenSimplexNoise.new()

func _ready() -> void:
	randomize()
	noise.seed = randi()
	print("seed: " + str(noise.seed))
	noise.octaves = octaves
	generate_map()
	
func generate_map() -> void:
	for x in width:
		for y in height:
			var rand := abs(noise.get_noise_2d(x, y))
			rand *= textureCount
			rand = floor(rand)
			tileMap.set_cell(x, y, rand)
			
# reload the scene when the enter key is clicked
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_end"):
		get_tree().reload_current_scene()
