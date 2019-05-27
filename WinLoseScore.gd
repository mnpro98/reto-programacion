extends Label

func _ready():
	set_text(str(GLOBAL.score))
	if(GLOBAL.score > GLOBAL.hScore):
		GLOBAL.hScore = GLOBAL.score
