extends Node

@onready var first = preload("res://audio/first.mp3")
@onready var second = preload("res://audio/second.mp3")
@onready var third = preload("res://audio/third.mp3")
@onready var win = preload("res://audio/win.mp3")
@onready var victory = preload("res://audio/victory.mp3")
@onready var tension = preload("res://audio/tension.mp3")

@onready var sword = preload("res://audio/sword.mp3")
@onready var shot = preload("res://audio/shot.mp3")
@onready var jump = preload("res://audio/jump.mp3")
@onready var loss = preload("res://audio/loss.mp3")
@onready var gun = preload("res://audio/gun_cocking.mp3")
@onready var blood = preload("res://audio/bloodsound.mp3")

@onready var musicPlayer = AudioStreamPlayer.new()
@onready var effectPlayer = AudioStreamPlayer.new()

var currentTrack = ""

func _ready():
	effectPlayer.volume_db = -5.0
	add_child(musicPlayer)
	add_child(effectPlayer)
	musicPlayer.connect("finished", Callable(self, "_on_music_finished"))

func playMusic(music):	
	if music == "":
		return
	if music == "first":
		musicPlayer.stream = first
		currentTrack = music
	if music == "second":
		musicPlayer.stream = second
		currentTrack = music
	if music == "third":
		musicPlayer.stream = third
		currentTrack = music
	if music == "win":
		musicPlayer.stream = win
		currentTrack = ""
	if music == "loss":
		musicPlayer.stream = loss
		currentTrack = ""
	if music == "victory":
		musicPlayer.stream = victory
		currentTrack = ""
	if music == "tension":
		musicPlayer.stream = tension
		currentTrack = ""
		
	musicPlayer.play()

	
func playEffect(effect):
	if effect == "shot":
		effectPlayer.stream = shot
	if effect == "blood":
		effectPlayer.stream = blood
	if effect == "sword":
		effectPlayer.stream = sword
	if effect == "jump":
		effectPlayer.stream = jump
	if effect == "loss":
		effectPlayer.stream = loss
	if effect == "cock":
		effectPlayer.stream = gun
	effectPlayer.play()
	
func _on_music_finished():
	playMusic(currentTrack)	
