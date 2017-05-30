//
//  VKStatusBarMessage.swift
//  CHIApplication
//
//  Created by Vlad on 5/30/17.
//  Copyright © 2017 Vlad_Kosyi. All rights reserved.
//

import UIKit

class ToggleStatusBarAlert: NSObject {

    var coveringWindow: UIWindow?
    
    static let shared = ToggleStatusBarAlert()
    open var controllerName : String = ""
    open var storyboardName : String = "Main"
    open var messageViewHeight : CGFloat = 50
    open var messageViewBackgroundColor : UIColor = UIColor.gray
    open var animationDuration : Double = 0.5
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMessage), name: Notification.Name("showMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideMessage), name: Notification.Name("hideMessage"), object: nil)
    }
    
    open func showMessage() {
        
        guard self.coveringWindow == nil else {
            print("Message showed")
            return
        }
        
        self.coveringWindow = UIWindow(frame: CGRect(x: 0, y: -messageViewHeight, width: UIScreen.main.bounds.width, height: messageViewHeight))
        
        if let coveringWindow = self.coveringWindow {
            
            let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
            let ThirdViewControllerVC = storyBoard.instantiateViewController(withIdentifier: controllerName)
            coveringWindow.rootViewController = ThirdViewControllerVC
            coveringWindow.windowLevel = UIWindowLevelNormal
            coveringWindow.backgroundColor = messageViewBackgroundColor
            
            
            UIView.animate(withDuration: animationDuration, animations: {
                
                coveringWindow.isHidden = false
                coveringWindow.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.messageViewHeight)
                coveringWindow.bounds = CGRect(x: 0, y: 0, width: coveringWindow.frame.size.width, height: coveringWindow.frame.size.height)
                
            }) { (result) in
                
            }
            
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            
            window.clipsToBounds = true
            let frame = UIScreen.main.bounds
            window.frame = CGRect(x: 0, y: self.messageViewHeight, width: frame.size.width, height: frame.size.height - self.messageViewHeight);
            window.bounds = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height);
            
        }) { (result) in
            
        }
    }
    
    open func hideMessage() {
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            
            window.clipsToBounds = true
            window.frame = UIScreen.main.bounds
            window.bounds = UIScreen.main.bounds
            
        }, completion: nil)
        
        
        if let coveringWindow = self.coveringWindow {
            
            let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
            let ThirdViewControllerVC = storyBoard.instantiateViewController(withIdentifier: controllerName)
            coveringWindow.rootViewController = ThirdViewControllerVC
            coveringWindow.windowLevel = UIWindowLevelNormal
            coveringWindow.backgroundColor = messageViewBackgroundColor
            
            
            UIView.animate(withDuration: animationDuration, animations: {
                
                coveringWindow.frame = CGRect(x: 0, y: -self.messageViewHeight, width: UIScreen.main.bounds.width, height: self.messageViewHeight)
                coveringWindow.bounds = CGRect(x: 0, y: 0, width: coveringWindow.frame.size.width, height: coveringWindow.frame.size.height)
                
            }) { (result) in
                coveringWindow.isHidden = true
                self.coveringWindow = nil
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("showMessage"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("hideMessage"), object: nil)
    }
}
