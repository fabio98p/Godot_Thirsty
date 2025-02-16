extends Control

@export var option_menu: PackedScene
var option_menu_instance: Control
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Example_level/example_level.tscn")

func _on_button_options_pressed() -> void:
	option_menu_instance = option_menu.instantiate()
	add_child(option_menu_instance)
	option_menu_instance.connect("hide_option_menu", Callable(self, "hide_option_menu"))

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func hide_option_menu() -> void:
	remove_child(option_menu_instance)
