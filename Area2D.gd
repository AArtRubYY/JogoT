extends Area2D

var ponto = 1

@onready var animacao = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "Player":
		Global.somaPontos -= ponto
		print (Global.somaPontos)
		animacao.play("coletado")
		await animacao.animation_finished
		queue_free()
