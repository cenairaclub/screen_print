# screen_print
A Godot Addon for Screen Debug Messages like Unreal Engine. Messages can have colors, durations and tags. Tags prevents repetitions. And you can clear messages with tags clear("tag") or you can call clear_all()

<img width="548" height="240" alt="image" src="https://github.com/user-attachments/assets/534fc9ef-654d-4563-bea8-62eda4e0edbf" />

Functions->
# Prints message to screen
`func print(message: String, color: Color = Color.CYAN, time: float = 3.0, tag: String = "")`

# Cleans a certain message
`func clear(tag: String):`

# Clear all the messages
`func clear_all():`

You can change the settings from this file:

<img width="219" height="140" alt="image" src="https://github.com/user-attachments/assets/cbbf2226-d63c-4c44-a330-8e87aba3a678" />

<img width="389" height="455" alt="image" src="https://github.com/user-attachments/assets/e10803f9-3379-4deb-9b3f-15fde17f646f" />
