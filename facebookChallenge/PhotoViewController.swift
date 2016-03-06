//
//  PhotoViewController.swift
//  facebookChallenge
//
//  Created by Tina Chen on 3/5/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButtonView: UIImageView!
    @IBOutlet weak var photoActions: UIImageView!
    @IBOutlet weak var bgView: UIView!
    var image: UIImage!
    var isPortrait: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.image = image
        if isPortrait! {
            photoView.frame.size.height = 460
        } else {
            photoView.frame.size.height = 200
        }
        photoView.center = view.center
        
        scrollView.contentSize = CGSize(width: 320, height: 570)
        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
    
        var offset = abs(scrollView.contentOffset.y)
        var alpha = convertValue(offset, r1Min: 0, r1Max: 400, r2Min: 1, r2Max: 0.4)
        view.backgroundColor = UIColor(white: 0, alpha: alpha)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        UIView.animateKeyframesWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
            self.photoActions.alpha = 0
            self.doneButtonView.alpha = 0
            }, completion: nil)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            if abs(scrollView.contentOffset.y) < 100 {
                UIView.animateKeyframesWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    self.photoActions.alpha = 1
                    self.doneButtonView.alpha = 1
                    }, completion: nil)
            } else {
                dismissViewControllerAnimated(true, completion: nil)
            }

    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        UIView.animateKeyframesWithDuration(0.1, delay: 0, options: [], animations: { () -> Void in
            
            }, completion: nil)
    }
    

    @IBAction func onTouchUp(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return photoView
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
