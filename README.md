# worldrtesttask

All generated code is committed, just build & install project

# Flutter Developer Test Task
 
The goal of this task is to create a mobile application using the Flutter framework, which consists of screens presented in the following picture:
https://worldr.com/flutter-test.png
The application should be able to compile for Android and iOS. It is not necessary to make a pixel-perfect application, an image provided is just an example of layout organization. Icons used in this mock-up can be found here: ​https://material.io/resources/icons/
# Description
- The application operates with three kinds of entities: ​Persons​ of two types (basketball and hockey players) and ​Messages.​
- Every entity contains an “unread” flag, and it is set to ​true​ in the beginning. Every Message​ should be connected with an existing ​Person​.
- We recommend using ​Hive​ for data organization, ​BLoC​ pattern for data flow organization and ​Faker​ package for random words and names generation.
- Header and footer of the application are rendered on top of content and are not involved in the page transition animations.
## Application lifecycle
- When the application starts, its DB should contain between 3 and 5 randomly generated ​Persons​ and between 5 and 10 messages.
- The ​Home​ screen should present a link (big circle buttons) to every other screen as well as quantity of entities displayed by that screen (if there are any).
- Every 1 to 5 seconds a new entity should be generated randomly and the home screen should accordingly be updated. If a user goes to one of the screens, entities displayed there that are visible to the user should be marked as read (flag “unread” sets to ​false​, ​Home​ screen updates correspondingly).
- Colors for ​Person​ icons are generated randomly, M​ essages​ colors are derived from a corresponding ​Person​.
  
# Screens and layout
## Footer
Active link is marked by its own colour, others are white. Transition animations — changing color from white to target one.

## Header
Header is animated separately from content.
- When the user goes from ​Home​ screen to ​Basketball​ or ​Hockey ​screen, the header
descends from the top of the screen; backwards — it disappears “above” the top of
the screen
- When the user goes from ​Basketball​ or ​Hockey​ screen to ​Messages​, the header
hides with a sliding animation to the left side while a new one slides from the right; backwards — ​Messages​ header slides to the right and ​Basketball​ or ​Hockey​ one slides from the left
- When user goes to ​Messages​ from ​Home​ and back, the behaviour is the same as above, but not involving ​Basketball​ or ​Hockey​ header
- Switching between ​Basketball​ and H​ ockey​ header: while the background moves toward the inactive tab, the underlining of the text also shifts to the active tab.
## Home
Contains no header, only footer and content. Every counter contains a quantity of “unread” entities for each screen. If there are more than 9, the counter displays “9+”.
## Basketball
Contains a scrollable list of ​Persons​ of type “basketball”. Initial scroll position: first entity right below the header with a decent margin. When scrolling down, upper entities are displayed below the header and are slightly visible.
## Hockey
Pretty much the same as the ​Basketball​ screen, but some “hockey” type ​Persons​ could have a right alignment.
## Messages
- Contains a list of ​Messages​ sent from P​ ersons​ presented in an application database.

 - Persons​ name should be aligned with the middle of an icon and can occupy 1 or 2 lines depending on how it fits.
- If the message itself does not fit into one line, the ​Message​ container should be expandable and have two states: expanded/collapsed. In the collapsed state the last 10-15 symbols should be obscured by gradient of the same colour as the background.
