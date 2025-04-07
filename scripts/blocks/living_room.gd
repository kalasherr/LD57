extends TowerBlock
class_name LivingBlock

var workers_count = 2

func init_variables():
	resources = {
	"wheat" : 7
	}

func work():
	if find_block_near("gym"):
		efficiency = 2
	else:
		efficiency = 1
