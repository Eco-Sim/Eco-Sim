extends CanvasLayer

@onready var build_menu := $Inner/BuildMenu as Panel

@export var research_ui: ResearchUI

func _ready() -> void:
	research_ui.visibility_changed.connect(func():
		self.visible = !research_ui.visible
	)

func _on_research_pressed() -> void:
	research_ui.visible = true

func _on_build_menu_pressed() -> void:
	build_menu.visible = !build_menu.visible
