extends TextureRect
class_name LeftPanel

var dict = {
	"LivingRoomBlock": [
"Living Room", 
"Gives 2 workers

Every worker needs 3 food per flip

If placed near Gym, workers' power is doubled

Even if worker is not working, he will eat his food, if you had enough"


],
	"FarmBlock" : [
"Farm",
"Every farm worker gives 10 food every flip. 

Doesn't work under the surface

Maximum workers: 2

x1.5 harvest if have Water nearby"
],
	"MineBlock" : [
"Mine",
"Every mine worker gives 2 ore every flip. Works only under the surface

If placed near Forge, every mine worker produces 1 ingot per flip

Maximum workers: 3"
],
	"BeaconBlock" : [
"Beacon",
"Place Beacon on your tower top/bottom block to finish the game

" + '"Guiding light from a piece of Moon"'],
	"MarketBlock" : [
"Market", 
"Sells part or your resources. Gives money every flip

Maximum workers: 1"
],
"ForgeBlock" : [
"Forge",
"All mines near Forge will produce ingots instead of ore"],
"WaterBlock" :
["Water Block" ,"Harvest on all farms near Water Blocks will be multiplied by 1.5"],
"GymBlock" : ["Gym", "Efficiency of all workers from living rooms near Gym is multiplied by 2"],
"ConnectorBlock" : ["Connector",
"All nearby blocks counts as neighbour to each other. Doesn't work with other Connectors"]
}
func get_info(block):
	$Name.text = dict[block.name][0]
	$PictureBox/Texture.texture = block.get_node("Sprite").texture
	$Description.text = dict[block.name][1]

func update_flips():
	$Flips.text = "Flips: " + str(G.game.flips)
