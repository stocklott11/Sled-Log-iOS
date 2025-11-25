# Overview

As a software engineer, I wanted to level up my experience with building real mobile apps instead of small practice screens. I chose to make something practical that I would actually use, which pushed me to think about structure, navigation, data flow, and persistence in a real project.

The app I built is called Sled Log. It lets me track all of my snowmobiles and the maintenance I do on each one. I can add sleds, view details, log service work, edit information, and remove anything that is outdated. The app saves everything locally on the device so the data is still there each time it opens. Using it is very simple. You can add a sled, tap it to view the details, and record maintenance as it happens. The main screen shows the full inventory, and each sled has its own service history.

My purpose for creating this app was to learn how to build a complete mobile app from scratch. I wanted something that tied together multiple screens, user input, stored data, and a clean interface on iOS. I also wanted it to be useful to me, which made the development process more motivating and meaningful.


[Software Demo Video](https://youtu.be/GIOBmB-iJLc)

# Development Environment

I built this app using Xcode on macOS. The user interface and features were created with Swift and SwiftUI, and the app runs on both the iOS Simulator and my iPhone for testing.
For data storage, I used Swift’s UserDefaults with JSON encoding to keep things simple while still keeping the data persistent across app launches.

# Useful Websites

* [Apple Developer Documentation for SwiftUI](https://developer.apple.com/documentation/swiftui)
* [Apple documentation for UserDefaults and data persistence](https://developer.apple.com/documentation/foundation/userdefaults)
* [Hacking with Swift - SwiftUI Tutorials](https://www.hackingwithswift.com/quick-start/swiftui) 

# Future Work

* Add photos for each sled and maintenance record
* Add reminders for scheduled maintenance
* Add reminders for scheduled maintenance
* Add more detailed maintenance fields like cost, parts used, or location