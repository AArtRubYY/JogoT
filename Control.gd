extends Control


@onready var timer_count = $MarginContainer/HBoxContainer/timer as Label

@onready var contador = $MarginContainer/pontos_contador/contador as Label

@onready var timer = $timer_cont as Timer

signal tempo_acabou ()

var minutos = 0
var segundos = 0

@export_range(0,2) var min_padrao = 1
@export_range (0,59) var seg_padrao = 0

func _ready():
	contador.text = str("%02d" % Global.somaPontos)
	minutos = min_padrao
	segundos = seg_padrao

func _process(delta):
	contador.text = str("%02d" % Global.somaPontos)
	if segundos == 0 && minutos == 0 :
		emit_signal("tempo_acabou")

func _on_timer_cont_timeout():
	if segundos >=60:
		segundos%= 60 
		minutos +=1 
		
	if segundos == 0:
		if minutos > 0:
			minutos -= 1
			segundos = 60 
	
	segundos -=1
	
	
	timer_count.text = str("%02d" % minutos + ":" + "%02d" % segundos)
	print(minutos, ":", segundos)
