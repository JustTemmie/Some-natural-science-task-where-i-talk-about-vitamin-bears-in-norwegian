extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textboxContainer = $TextboxContainer
onready var startSymbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
onready var endSymbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
onready var tween = $Tween

export var text1 = "None"
export var text2 = "None"
export var text3 = "None"
export var text4 = "None"
export var text5 = "None"
export var text6 = "None"
export var text7 = "None"
export var text8 = "None"
export var text9 = "None"
export var text10 = "None"
export var text11 = "None"
export var text12 = "None"
export var text13 = "None"
export var text14 = "None"
export var text15 = "None"
export var text16 = "None"
export var text17 = "None"
export var text18 = "None"
export var text19 = "None"
export var text20 = "None"
export var text21 = "None"
export var text22 = "None"
export var text23 = "None"
export var text24 = "None"
export var text25 = "None"
export var text26 = "None"
export var text27 = "None"
export var text28 = "None"
export var text29 = "None"
export var text30 = "None"
export var text31 = "None"
export var text32 = "None"
export var text33 = "None"
export var text34 = "None"
export var text35 = "None"
export var text36 = "None"
export var text37 = "None"
export var text38 = "None"
export var text39 = "None"
export var text40 = "None"
export var text41 = "None"
export var text42 = "None"
export var text43 = "None"
export var text44 = "None"
export var text45 = "None"
export var text46 = "None"
export var text47 = "None"
export var text48 = "None"
export var text49 = "None"
export var text50 = "None"

export var npc_number = 0 

onready var rawtext = [text1, text2, text3, text4, text5, text6, text7, text8, text9, text10]
onready var secondrawtext = [text11, text12, text13, text14, text15, text16, text17, text18, text19, text20]
onready var thirdrawtext = [text21, text22, text23, text24, text25, text26, text27, text28, text29, text30]
onready var fourthrawtext = [text31, text32, text33, text34, text35, text36, text37, text38, text39, text40]
onready var fifthrawtext = [text41, text42, text43, text44, text45, text46, text47, text48, text49, text50]



enum State {
	READY,
	READING,
	FINISHED
}

var currentState = State.READY
var text_queue = []
var dialogue = []
var inRange = 0
var dialoguePage = 1

func _ready():
	print("changing text state to: READY")
	hide_textbox()

# warning-ignore:unused_argument
func _process(delta):
	match currentState:
		State.READY:
			if !text_queue.empty():
				display_text()

			elif inRange == 1 and Input.is_action_just_pressed("interact"):
				Stats.can_move = 0
				if dialoguePage == 1:
					dialoguePage = 2
					add_to_dialogue(rawtext)
				elif dialoguePage == 2:
					dialoguePage = 3
					add_to_dialogue(secondrawtext)
				elif dialoguePage == 3:
					dialoguePage = 4
					add_to_dialogue(thirdrawtext)
					Stats.can_start = 1
				elif dialoguePage == 4:
					dialoguePage = 5
					add_to_dialogue(fourthrawtext)
				elif dialoguePage == 5:
					dialoguePage = 1
					add_to_dialogue(fifthrawtext)
					if npc_number == 0:
						Counter.id0 = true
					if npc_number == 1:
						Counter.id1 = true
					if npc_number == 2:
						Counter.id2 = true
					if npc_number == 3:
						Counter.id3 = true
					if npc_number == 4:
						Counter.id4 = true
					if npc_number == 5:
						Counter.id5 = true

				for i in dialogue:
					queue_text(i)

		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1.0
				tween.stop_all()
				endSymbol.text = "*"
			if label.percent_visible == 1.0:
				endSymbol.text = "*"
				change_state(State.FINISHED)
				

		State.FINISHED:
			if Input.is_action_just_pressed("interact"):
				change_state(State.READY)
				hide_textbox()


func queue_text(nextText):
	text_queue.push_back(nextText)

func hide_textbox():
	startSymbol.text = ""
	endSymbol.text = ""
	label.text = ""
	textboxContainer.hide()
	
func show_textbox():
	startSymbol.text = "*"
	textboxContainer.show()

func display_text():
	
	var nextText = text_queue.pop_front()
	label.text = nextText
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(nextText) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func add_to_dialogue(page):
	dialogue = []
	for i in page:
		if not "None" in i:
			dialogue.append(i)
	if not dialogue:
		add_to_dialogue(rawtext)
		if npc_number == 0:
			Counter.id0 = true
		if npc_number == 1:
			Counter.id1 = true
		if npc_number == 2:
			Counter.id2 = true
		if npc_number == 3:
			Counter.id3 = true
		if npc_number == 4:
			Counter.id4 = true
		if npc_number == 5:
			Counter.id5 = true


func _on_Tween_tween_completed():
	endSymbol.text = "*"
	change_state(State.FINISHED)

func change_state(nextState):
	currentState = nextState
	match currentState:
		State.READY:
			print("changing text state to: READY")
			Stats.can_move = 1
		State.READING:
			print("changing text state to: READING")
			Stats.can_move = 0
		State.FINISHED:
			print("changing text state to: FINISHED")
			


func _on_InteractionComponent_body_entered(body):
	if body.name == "Player":
		inRange = 1	


func _on_InteractionComponent_body_exited(body):
	if body.name == "Player":
		inRange = 0
