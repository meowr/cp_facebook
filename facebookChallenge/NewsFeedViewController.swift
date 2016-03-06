//
//  NewsFeedViewController.swift
//  facebookChallenge
//
//  Created by Tina Chen on 2/2/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var infiniteScrollingIndicator: UIActivityIndicatorView!
    
    var numberOfImageViews: CGFloat = 1
    var refreshControl: UIRefreshControl!
    var selectedImageView: UIImageView!
    var imageTransition: ImageTransition!
    var isPortrait: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1438)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        scrollView.insertSubview(refreshControl, atIndex: 0)
        
    
        infiniteScrollingIndicator.center.y = feedImageView.image!.size.height + 20
        scrollView.contentInset.bottom = 130
        
        scrollView.delegate = self
        
        isPortrait = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
//        feedImageView.hidden = true
//        loadingIndicator.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
//        delay(2) { () -> () in
//            self.feedImageView.hidden = false
//            self.loadingIndicator.stopAnimating()
//        }
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("Scrolling Stopped")
        // If the scrollView offset + the scrollview height is greater than or equal to the height of the scrollView content,
        // We have reached the bottom, so...
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            print("You reached the bottom")
            
            // Delay for 1 second then...
            delay(1, closure: { () -> () in
                // Create frame for new imageView, same as feed ImageView
                let newFrame = self.feedImageView.frame
                // Create new ImageView with newFrame
                let newImageView = UIImageView(frame: newFrame)
                // Create new image, same as feed Image
                let newImage = UIImage(named: "home_feed-1")
                // Set new ImageView image to newImage
                newImageView.image = newImage
                // Position the new imageView below the previous image view
                newImageView.frame.origin.y = self.feedImageView.frame.origin.y + self.numberOfImageViews * self.feedImageView.frame.size.height
                // Add imageView to scrollView
                scrollView.addSubview(newImageView)
                // Move Activity Indicator down below new ImageView
                self.infiniteScrollingIndicator.center.y = self.feedImageView.image!.size.height + 20 + self.numberOfImageViews * newImageView.image!.size.height
                // Increase the feedScrollView contentSize with each additional imageView added using
                scrollView.contentSize = CGSize(width: self.feedImageView.frame.size.width,
                    height: self.feedImageView.frame.size.height + self.numberOfImageViews * newImageView.frame.size.height)
                // add 1 to scrollViewCount
                self.numberOfImageViews += 1
            })
        }
    }

    @IBAction func onTapPhoto(sender: UITapGestureRecognizer) {
        selectedImageView = sender.view as! UIImageView
        if selectedImageView.image!.size.height > selectedImageView.image!.size.width {
            isPortrait = true
        } else {
            isPortrait = false
        }
        performSegueWithIdentifier("photoSegue", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       var destinationViewController = segue.destinationViewController as! PhotoViewController
        destinationViewController.image = selectedImageView.image
        print("setimage")
        destinationViewController.isPortrait = isPortrait
        print("setportrait")
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        imageTransition = ImageTransition()
        destinationViewController.transitioningDelegate = imageTransition
        imageTransition.duration = 0.3
       
    }

}
