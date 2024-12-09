extends CanvasLayer

@export var research_ui: ResearchUI

func _ready() -> void:
	research_ui.visibility_changed.connect(func():
		visible = !research_ui.visible
	)

func _on_research_pressed() -> void:
	research_ui.visible = true

func _on_build_menu_pressed() -> void:
	pass # Replace with function body.
