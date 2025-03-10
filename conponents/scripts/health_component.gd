extends Node2D


@export var MAX_HEALTH = 10

var health

func _ready() -> void:
	health = MAX_HEALTH
	
	
func damage(damage: int):
	health -= damage
