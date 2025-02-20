extends Node2D

@onready var hud: Control = $Camera2D/HUD
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@export var pause_menu: PackedScene
@export var option_menu: PackedScene
@export var player_position: Vector2 = Vector2(531, 530)
var pause_menu_instance
var option_menu_instance 
var pause_already_pressed := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = player_position
	#get_node("Player_and_Hud").get_node("Player").connect("player_dead", Callable(self, "death_player"))
	#get_node("Player_and_Hud").get_node("Player").connect("player_dead", Callable(self, "death_player"))
	player.connect("player_dead", Callable(self, "death_player"))
	player.connect("player_hit", Callable(self, "playerHitted"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if pause_already_pressed:
		pause_game(false)
		pause_already_pressed = false
	elif event.is_action_pressed("pause"):
		#controllare se c'è gia il child di pause
		pause_menu_instance = pause_menu.instantiate()
		pause_menu_instance.connect("pause_delete", Callable(self, "on_pause_delete"))
		pause_menu_instance.connect("reset_level", Callable(self, "restart_game"))
		pause_menu_instance.connect("options", Callable(self, "option_game"))
		pause_menu_instance.connect("main_menu", Callable(self, "main_menu_game"))
		add_child(pause_menu_instance)
		pause_already_pressed = true
		pause_game(true)
		
func connectToPlayerHit(bullet: Bullet):
	bullet.connect("playerHit", Callable(self, "playerHitted"))

func playerHitted():
	print("player take a hit")
	hud.change_afterlife(player.current_hp)

func on_pause_delete():
	print("funzioone")
	remove_child(pause_menu_instance)
	hide_option_menu()
	pause_game(false)
	
func pause_game(value: bool) -> void:
	get_tree().paused = value
	
func restart_game() -> void:
	pause_game(false)
	get_tree().reload_current_scene()
	
func option_game() -> void:
	pause_menu_instance.visible = false
	option_menu_instance = option_menu.instantiate()
	add_child(option_menu_instance)
	option_menu_instance.connect("hide_option_menu", Callable(self, "hide_option_menu"))
	
func main_menu_game() -> void:
	pause_game(false)
	get_tree().change_scene_to_file("res://menus/scenes/main_menu.tscn")
	
func hide_option_menu() -> void:
	remove_child(option_menu_instance)
	pause_menu_instance.visible = true
	
func death_player()-> void:
	get_tree().reload_current_scene()
