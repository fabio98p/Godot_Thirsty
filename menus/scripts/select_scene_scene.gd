extends Control

signal hide_select_scene 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level_city/level_city.tscn")


func _on_button_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level_forest/level_forest.tscn")


func _on_button_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level_boss/level_boss.tscn")


func _on_button_level_4_pressed() -> void:
	hide_select_scene.emit()
