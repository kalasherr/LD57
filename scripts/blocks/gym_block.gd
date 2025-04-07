extends TowerBlock
class_name GymBlock

func check_condition(condition):
	if condition == "gym":
		return true
	return false

func init_variables():
	resources = {
	"wheat" : 8,
	"ore" : 10
	}
