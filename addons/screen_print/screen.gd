extends Node

var message_container: VBoxContainer
var message_labels: Dictionary = {}
var message_timers: Dictionary = {}
var random_number_generator : RandomNumberGenerator

var settings = preload("res://addons/screen_print/SETTINGS.tres")

func _ready():
	random_number_generator = RandomNumberGenerator.new()
	# Main node setup
	set_process_mode(Node.PROCESS_MODE_ALWAYS)

	# Create a Canvas Layer
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100  # put on the Top
	add_child(canvas_layer)

	# Creating a main container
	message_container = VBoxContainer.new()
	message_container.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT)
	message_container.position = Vector2(10, 10)  # 10px inside of the Top Left
	canvas_layer.add_child(message_container)
func print(message: String, color: Color = Color.CYAN, time: float = 3.0, tag: String = "") -> void:
	if settings.HIDE_ALL_MESSAGES:
		return

	var should_print: bool = (not settings.EDITOR_ONLY_MESSAGES) or (settings.EDITOR_ONLY_MESSAGES and OS.has_feature("editor"))
	if should_print:
		# If tag is empty, create a unique tag
		if tag.is_empty():
			tag = "msg_%d_%d" % [Time.get_ticks_msec(), random_number_generator.randi()]

		# If there is a message with the same tag, update the previous message.
		if message_labels.has(tag):
			_update_message(tag, message, color, time)
		else:
			_create_message(tag, message, color, time)
func _create_message(tag: String, message: String, color: Color, time: float):
	# Create a label
	var label = Label.new()
	label.text = message
	label.modulate = color
	label.add_theme_font_size_override("font_size", settings.FONT_SIZE)

	# add to the Container
	message_container.add_child(label)
	message_labels[tag] = label

	# create a timer
	var timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = true
	timer.timeout.connect(_on_message_timeout.bind(tag))
	add_child(timer)
	timer.start()

	message_timers[tag] = timer

func _update_message(tag: String, message: String, color: Color, time: float):
	# Updating the message
	var label = message_labels[tag]
	label.text = message
	label.modulate = color

	# Reseting the timer
	var timer = message_timers[tag]
	timer.wait_time = time
	timer.start()

func _on_message_timeout(tag: String):
	# Remove the message
	if message_labels.has(tag):
		var label = message_labels[tag]
		label.queue_free()
		message_labels.erase(tag)

	if message_timers.has(tag):
		var timer = message_timers[tag]
		timer.queue_free()
		message_timers.erase(tag)

# Clear all the messages
func clear_all():
	for tag in message_labels.keys():
		_on_message_timeout(tag)

# Cleans a certain message
func clear(tag: String):
	if message_labels.has(tag):
		_on_message_timeout(tag)