extends Node2D

@onready var player = $Player


func _ready():
	player.morri.connect(_resetar)
func _resetar():
	get_tree().reload_current_scene()
	Global.somaPontos = 0
