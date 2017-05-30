# ToggleStatusBarAlert

* [Demo](#demo)
* [Usage example](#usage-example)

A library for showing notification like Toggle In-call status bar.
Works with any types of controls (Root, Modal)
For example, for "No internet connection" message.

# Demo

![](https://github.com/vlaskos/ToggleStatusBarAlert/blob/master/Resources/4.gif)

# Usage example

# Initialization 

- Create freedom ViewController for message with custom height (e.g. 50)

![](https://github.com/vlaskos/ToggleStatusBarAlert/blob/master/Resources/6.jpg)

- Add storyboard Id for controller and press mark Use Storyboard Id

![](https://github.com/vlaskos/ToggleStatusBarAlert/blob/master/Resources/2.jpg)

- Set color for view in controller "Clear"

![](https://github.com/vlaskos/ToggleStatusBarAlert/blob/master/Resources/5.jpg)

- Add ToggleStatusBarAlert.swift in project 
- Initialize ToggleStatusBarAlert

        let statusBarMessage = ToggleStatusBarAlert.shared
        statusBarMessage.storyboardName = "Main"
        statusBarMessage.controllerName = "ToggleStatusBarAlert"
        statusBarMessage.messageViewHeight = 50
        statusBarMessage.messageViewBackgroundColor = UIColor(red: 255.0 / 255.0, green: 200.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
        statusBarMessage.animationDuration = 0.5

- You can use some methods for show and hide alert

      ToggleStatusBarAlert.shared.showMessage()

      ToggleStatusBarAlert.shared.hideMessage()

- Also, you can use NotificationCenter 

       NotificationCenter.default.post(name: Notification.Name("showMessage"), object: nil)
       
       NotificationCenter.default.post(name: Notification.Name("hideMessage"), object: nil)

- Also, you can run the test project "ToggleStatusBarAlert".

Developed By
------------
* Kosyi Vlad
