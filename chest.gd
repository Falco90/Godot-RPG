extends Node2D

signal toggle_inventory(external_inventory_owner)
@export var inventory_data: InventoryData

func player_interact() -> void:
	toggle_inventory.emit(self)
	
var player_in_pickupzone = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	deal_with_pickup()
	
func _on_pickup_area_body_entered(body):
	if body.has_method("player"):
		print("zone entered")
		player_in_pickupzone = true

func _on_pickup_area_body_exited(body):
	if body.has_method("player"):
		print("zone exited")
		player_in_pickupzone = false

func deal_with_pickup():
	if player_in_pickupzone and Input.is_action_just_pressed("interact"):
		player_interact()
