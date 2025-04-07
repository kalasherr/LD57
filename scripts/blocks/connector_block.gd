extends TowerBlock
class_name ConnectorBlock

func check_condition(condition):
	if find_block_near(condition):
		return true
	return false

func init_variables():
	resources = {
	"coins" : 5,
	"ore" : 5
	}
