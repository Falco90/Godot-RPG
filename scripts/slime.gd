extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var player_in_attackzone = false
var player_in_talkrange = false
var health = 100

var can_take_damage = true

func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	player_in_talkrange = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	player_in_talkrange = false

func enemy():
	pass


func _on_slime_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attackzone = true


func _on_slime_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attackzone = false

func deal_with_damage():
	if player_in_attackzone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func talk_with_player():
	if player_in_talkrange == true and global.player_talking == true:
		var json = JSON.stringify(global.player_message)
		var headers = ["Content-Type: application/json"]
		$HTTPRequest.request("http://localhost:5000/openai", headers, HTTPClient.METHOD_POST, json)
		
func _on_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8())
