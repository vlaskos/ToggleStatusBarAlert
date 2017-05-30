//
//  StatusBarAlertController.swift
//  statusBarAlert
//
//  Created by vlaskos on 5/29/17.
//  Copyright © 2017 vlaskos. All rights reserved.
//

import UIKit

class StatusBarAlertController: UIViewController {

    fileprivate var statusBar : UIView! = UIView()
    open var statusBarLabel : UILabel! = UILabel()
    open var visiblity : Bool! = false
    open var overlayStyle : Bool! = false
    open var rootViewController: UIViewController!
    open var statusBarHeight : CGFloat = 50
    
    weak var delegate: StatusBarControllerDelegate?
    
    
    override init(nibName: String?, bundle nibBundle: Bundle?) {
        
        super.init(nibName: nibName, bundle: nibBundle)
        self.statusBarLabel.text = ""
    }
    
    required init?(coder decoder: NSCoder) {
        
        super.init(coder: decoder)
    }
    
    convenience init(rootViewController: UIViewController) {
        
        self.init()
        
        self.rootViewController = rootViewController
        self.statusBarLabel.text = ""
    }
    
    override func loadView() {
        
        self.view = UIView()
        
        self.view.addSubview(rootViewController.view)
        
        self.view.addSubview(statusBar)
        
        statusBar.addSubview(statusBarLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusBar.clipsToBounds = true
        statusBar.backgroundColor = UIColor.yellow
        
        statusBarLabel.textColor = UIColor.black
        statusBarLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        statusBarLabel.backgroundColor = UIColor.clear
        statusBarLabel.textAlignment = .center
        statusBarLabel.numberOfLines = 0
        statusBarLabel.lineBreakMode = .byTruncatingTail
        
        self.setupNotificationCenter()
        
    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
        
        rootViewController.view.frame = self.frameForRootController()
        statusBar.frame = self.frameForStatusBar()
        statusBarLabel.frame = self.frameForStatusBarLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
            statusBar = nil
            statusBarLabel = nil
            rootViewController = nil
    }
    //-----------------------------------------------------------------------------------
    // MARK: -
    // MARK: Public
    
    func setupNotificationCenter() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.noInternetConnectionMessage), name: Notification.Name("noInternetConnectionMessage"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.internetConnectionMessage), name: Notification.Name("internetConnectionMessage"), object: nil)
        
    }
    
    func noInternetConnectionMessage() {
        
        self.setVisibility(visible: true, animated: true, message: "NO INTERNET CONNECTION")
    }
    
    func internetConnectionMessage() {
        
        self.setVisibility(visible: false, animated: true, message: "NO INTERNET CONNECTION")
    }
    
    open func setStatusMessage(text : String) {
     
        statusBarLabel.text = text;
        statusBarLabel.frame = self.frameForStatusBarLabel()
    }
    
    open func setVisibility(visible : Bool, animated: Bool) {
        
        visiblity = visible
        self.resizeViewsAnimated(animated: animated)
    }
    
    open func setVisibility(visible : Bool, animated: Bool, message: String) {
        
        self.setStatusMessage(text: message)
        self.setVisibility(visible: visible, animated: animated)
    }
    
    
    open func setOverlayStyle(overlayStyle : Bool) {
        
        self.overlayStyle = overlayStyle
        self.viewWillLayoutSubviews()
    }
    

    
    
    //-----------------------------------------------------------------------------------
    // MARK: -
    // MARK: Private
    
    fileprivate func colorForStatusLabelText() -> UIColor {
        return UIColor.init(colorLiteralRed: 191.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha: 1.0)
    }
    
    fileprivate func frameForRootController() -> CGRect {
        
        var frame : CGRect = self.view.bounds
        
        if visiblity && !overlayStyle {
            
            frame.size.height = frame.size.height - self.statusBarHeight
            frame.origin.y = frame.origin.y + self.statusBarHeight
        }
        
        return frame
        
    }
    
    fileprivate func frameForStatusBar() -> CGRect {
        
        var frame : CGRect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 0)
        
        if visiblity {
            
            frame.size.height = self.statusBarHeight
        }
        
        return frame

    }
    
    fileprivate func frameForStatusBarLabel() -> CGRect {
        
        let sizeNeededForText : CGSize = (statusBarLabel.text! as NSString).size(attributes: [NSFontAttributeName: statusBarLabel.font])
        
        let width : CGFloat = min(sizeNeededForText.width, statusBar.bounds.size.width)
        let height : CGFloat = min(sizeNeededForText.height, statusBar.bounds.size.height)
        let x : CGFloat = (statusBar.bounds.size.width / 2) - (width / 2)
        
        return CGRect(x: x, y: 30, width: width, height: height)
        
    }
    
    fileprivate func resizeViewsAnimated(animated: Bool) -> Void {
        
        delegate?.statusBarController(controller: self, willShowStatusBar: visiblity, animated: animated)
        
        UIView.animate(withDuration: animated ? 0.7 : 0, animations: {
            
            self.viewWillLayoutSubviews()
            
        }) { (finished) in
            
            self.delegate?.statusBarController(controller: self, didShowStatusBar: self.visiblity, animated: animated)
        }
    }

}

protocol StatusBarControllerDelegate : class {
    
    func statusBarController(controller:StatusBarAlertController, didShowStatusBar : Bool, animated: Bool)
    
    func statusBarController(controller:StatusBarAlertController, willShowStatusBar : Bool, animated: Bool)
    
}
