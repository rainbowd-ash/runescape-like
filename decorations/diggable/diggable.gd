extends StaticBody3D



func interact():
	print("dug!")
	Router.player_inventory.create_and_add_item("artifact")
