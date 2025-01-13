extends Node
# Router Autoload
# Used by nodes across the game to access frequently needed nodes like Player and World.

var root = "/root/World/"

@onready var player_inventory = get_node(root + "Player/Inventory")
