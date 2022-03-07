extends Node

#Object access
var current_mail


#Visible variables
export var money = 800 setget set_money, get_money
export var mental_health = 80 setget set_mental_health, get_mental_health

#Invisible variables
var mood = 100 setget set_mood, get_mood #Humeur
var fame = 0 setget set_fame, get_fame #Exposition
var workload = 0 setget set_workload, get_workload #Charge_mental

#Signals
#Visible stats
signal money_changed
signal mental_changed

#Invisible stats
signal mood_changed
signal fame_changed
signal workload_changed


func set_current_mail(var id : int):
	var mails = DataSystem.mails
	for mail in mails:
		if int(mail["ID"]) == id:
			current_mail = mail
			return
	printerr("GameSystem.set_current_mail(id : int) return no mails")

func unset_current_mail():
	current_mail = null

#Visible Stats
#Money
func set_money(value):
	money = value 
	emit_signal("money_changed", value)
	
	#Defeat condition
	if money <= 0:
		_lose_broke()

func get_money():
	return money

func calculate_money(value : int):
	var new_money = value + get_money()
	set_money(new_money)


#Mental
func set_mental_health(value):
	mental_health = value
	emit_signal("mental_changed", value)
	
	#Defeat condition
	if mental_health <= -100:
		_lose_burn_out()

func get_mental_health():
	return mental_health

func calculate_mental(value : int):
	var new_mental = value + get_mental_health()
	set_mental_health(new_mental)

#Invisible stats
#Mood
func set_mood(value):
	mood = value
	emit_signal("mood_changed", value)

func get_mood():
	return mood

func calculate_mood(value : int):
	var new_value = value + get_mood()
	set_mood(new_value)

#Fame
func set_fame(value):
	fame = value
	emit_signal("fame_changed", value)

func get_fame():
	return fame

func calculate_fame(value : int):
	var new_value = value + get_fame()
	set_fame(new_value)

#Workload
func set_workload(value):
	workload = value
	emit_signal("workload_changed", value)

func get_workload():
	return workload

func calculate_workload(value : int):
	var new_value = value + get_workload()
	set_workload(new_value)

#Win/Lose conditions
#Bad mental health
func _lose_burn_out():
	print("burn_out")
	pass

#No more money for rent
func _lose_broke():
	print("broke")
	pass

#Tons of money !
func _win_rich():
	pass

#Good social life
func _win_social_life():
	pass

#Famous as f*ck
func _win_famous():
	pass

#Yeah, you got it all !
func _win_equilibrium():
	pass
