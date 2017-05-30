//
//  SecontViewController.swift
//  statusBarAlert
//
//  Created by vlaskos on 5/29/17.
//  Copyright © 2017 vlaskos. All rights reserved.
//

import UIKit

class SecontViewController: UIViewController {

    @IBOutlet var pressBytton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dissmis(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func action(_ sender: Any) {
        
        if pressBytton.tag == 0 {
            pressBytton.tag = 1
            
                        NotificationCenter.default.post(name: Notification.Name("noInternetConnectionMessage"), object: nil)
            
        } else  {
            pressBytton.tag = 0
            
                        NotificationCenter.default.post(name: Notification.Name("internetConnectionMessage"), object: nil)
        }
    }
}
