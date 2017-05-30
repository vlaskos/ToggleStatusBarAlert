//
//  ViewController.swift
//  statusBarAlert
//
//  Created by vlaskos on 5/29/17.
//  Copyright © 2017 vlaskos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var pressButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            NotificationCenter.default.post(name: Notification.Name("noInternetConnectionMessage"), object: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressButtonAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        
//
//        window.backgroundColor = UIColor.white
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let modalViewController = storyBoard.instantiateViewController(withIdentifier: "SecontViewController") as! SecontViewController
        present(modalViewController, animated: true) {
            modalViewController.view.frame = self.view.frame
        }
        
        if pressButton.tag == 0 {
            pressButton.tag = 1
            
//            UIView.animate(withDuration: 0.5, animations: { 
//                window.clipsToBounds = true
//                window.frame = CGRect(x: 0, y: 50, width: window.frame.size.width, height: window.frame.size.height - 50);
//                window.bounds = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height);
//                let view = UIView.init(frame: CGRect(x: 0, y: -50, width: window.frame.size.width, height: 50))
//                view.clipsToBounds = true
//                view.backgroundColor = UIColor.yellow
//                window.addSubview(view)
//            }, completion: nil)
            

            
//            NotificationCenter.default.post(name: Notification.Name("noInternetConnectionMessage"), object: nil)

        } else  {
            pressButton.tag = 0
            
//            UIView.animate(withDuration: 0.5, animations: {
//                window.clipsToBounds = true
//                window.frame = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height + 50);
//                window.bounds = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height);
//            }, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("internetConnectionMessage"), object: nil)
        }
        
    }

}

