extends TowerBlock

func check_condition(condition):
	if condition == "forge":
		return true
	return false

func init_variables():
	resources = {
	"coins" : 10,
	"ore" : 20
	}
