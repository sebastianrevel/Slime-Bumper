# Slime Bumper

***Slime Bumper is an addictive, fast-paced game for iOS.***

* Code must be run on Xcode in order to be functional, no other ide's will suffice.

## GameScene

### Core Mechanics

*This section will detail the broad overview of the gameplay and how a user can progress and lose in the game.*

* User will be prompted to tap a slime as soon as game starts
* Once the user taps the slime, the prompt will disappear and the time bar at the top of the screen will start to deplete.
* If user doesn't tap again after the first tap, the bar will fully deplete in precisely 5 seconds.
* If the user does tap another slime after the first tap, the bar will increase in width by 7.5%.
* If the user happens to tap a cat, the game will end and score and highscore will be saved.
* The difficulty of the game does not increase over time but every mistake will build up over time. Meaning that if a user makes a
  mistake earlier on where they are tapping a slow rate, that loss of time will follow them unti the end. This unforgiving gameplay
  will encourage the user to be agile, quick, and accurate from the very beginning.

### Gameplay Specifics

*This section will detail the specifics in the gameplay, i.e spawn mechanics, animations, and records.*

* When scene one is called it will prompt a flashing text saying "tap a slime to begin."
* As soon as there is user interaction, i.e the user touching a slime, a fucntion will be called to shrink the respective slime to 0.
* Once the slime is fully shrunk, the generator function will grab a boolean and based on that boolean it will create either a slime
  or a cat.
* Whichever is spawned, their sprite will grow from 0 to 1 to represent a spawn.
* If a cat is spawned, it will only exist for roughly a second until it despawns and turns into a slime
* No matter what, if a cat is spawned, the next spawn in that node will be a slime. This will give the gameplay some degree of
  control.
* On a different note, every time a slime is hit, the player's icon will punch the respective slime with an animation and rotate
  that icon and point it to the direction of the node.
* If the user unfortunately hits a cat, the gamescene will transition to the gameover scene.
* If the score the user has is higher than the recorded highscore, the highscore will change to the current score.

## MenuScene

### Layout

*This section will give an overview of the layout of the main menu*

* As soon as the app starts up, it will enter the main menu screen.
* The main menu screen contains the title screen and a hefty amount of animations for aesthetic.
* This screen has two interactive nodes
    * The start game button
    * A store tab
* The start game button, when touched, will send the user to the GameScene with a transition.

### Store
*This section will detail the specifics of the store tab in the main menu*

* The store tab, when touched, will pull up a store with 5 different options for the players character/icon.
* The first icon is the red glove, which is the default icon for the player. The following icons are hidden behind an in-game paywall.
* The cost of the following items increase in order from left to right.
* Points are earned in game. (for every 25 points, 1 point of ingame currency will be added to the user's total)
* If the user can't afford a certain item, the item of interest will shake indicating that it cannot be bought.
* If the user can afford a certain item, it will be bough and a cha-ching sound will play. The user can then change to the item
  will change in game.

## EndScene
### Score
*This section will give an overview of the score features of the Game Over scene*

* Every Game Over transition will check to see if the users current score is higher than their high score, if it is, the high score will change accordingly.
* The game over scene will display the users current score as well as their high score.

### Transition Buttons
*This section will detail the functionality of the two transition buttons in the game Over scene*

* When the Try Again button is touched, game will transition back into the GameScene and restart the cycle
* When the Main Menu button is touched, the game will transition back into the main menu, allowing the player to purchase any items with the points they just earned



*One thing to note for the Xcode simulators: When the app is ran on the simulators their fps are not represented of the actual iPhone implementation. So if you are getting <30 frames on the iPhone X simulator, rest assured the game runs consistently 55-60 frames on an actual phone.*
