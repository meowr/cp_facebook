//
//  LoginViewController.swift
//  facebookChallenge
//
//  Created by Tina Chen on 2/10/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var labelparentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var initialFieldParentY: CGFloat!
    var initialLogoY: CGFloat!
    var initiallabelparentView: CGFloat!
    
    let alertController = UIAlertController(title: "Access Denied", message: "Wrong email or password", preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        // handle cancel response here. Doing nothing will dismiss the view.
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        initialFieldParentY = fieldParentView.frame.origin.y
        initialLogoY = logo.frame.origin.y
        initiallabelparentView = labelparentView.frame.origin.y
        
        alertController.addAction(cancelAction)
        loginButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        fieldParentView.frame.origin.y = initialFieldParentY - (frame.height/3)
        logo.frame.origin.y = initialLogoY - (frame.height/4)
        labelparentView.frame.origin.y = initiallabelparentView - (frame.height-37)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        fieldParentView.frame.origin.y = initialFieldParentY
        logo.frame.origin.y = initialLogoY
        labelparentView.frame.origin.y = initiallabelparentView
    }
    
    
    @IBAction func onLoginButton(sender: UIButton) {
        activityIndicator.startAnimating()
            if emailField.text == "t" && passwordField.text == "p" {
                delay(2) {
                    self.activityIndicator.stopAnimating()
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                }
            } else {
                delay(2) {
                    self.activityIndicator.stopAnimating()
                    self.presentViewController(self.alertController, animated: true) {
                }
            }
        }

    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
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
