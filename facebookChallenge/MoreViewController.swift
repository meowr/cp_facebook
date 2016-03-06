//
//  MoreViewController.swift
//  facebookChallenge
//
//  Created by Tina Chen on 2/2/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let alertController = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .ActionSheet)

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width:320, height: 1928)
        
        let logoutAction = UIAlertAction(title: "Log Out", style: .Destructive) { (action) in
            self.performSegueWithIdentifier("logoutSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onButton(sender: AnyObject) {
        presentViewController(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
