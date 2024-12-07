extends Node

@export var click_sound := preload("res://assets/audio/click.ogg")

func play(parent: Node) -> void:
    var audio_player := AudioStreamPlayer2D.new()
    parent.add_child(audio_player)

    audio_player.stream = click_sound
    audio_player.finished.connect(audio_player.queue_free.bind())

    audio_player.play()