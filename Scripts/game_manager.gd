extends Node2D

var score =0
@onready var game_manager: Node2D = %GameManager


func add_point():
	score += 1
	print(score)
