""" #The NPC will have the following conversation behavior, when a playing presses the letter 'E
or if a player clicks on the NPC, the NPC will say "Hello, {PlayerName}!", waits for 2 seconds and says 
"How is your stay at the inn?". Dialogue will be displayed in a box on the bottom left of the players viewport.
After the 2nd dialogue, the conversation ends and dialogue box will disappear after 1 second.
"""


import time
class NPC:
    def __init__(self, name):
        self.name = name
    
    def interact(self, player_name):
        return f"Hello, {player_name}!", "How is your stay at the inn?"
    