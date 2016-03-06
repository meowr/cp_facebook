//
//  ImageTransition.swift
//  facebookChallenge
//
//  Created by Tina Chen on 3/5/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let newsFeedViewController = fromViewController as! NewsFeedViewController
        let photoViewController = toViewController as! PhotoViewController
        let movingImageView = UIImageView()
        var globalFrame = CGRect()
        globalFrame = containerView.convertRect(newsFeedViewController.selectedImageView.frame, fromView: newsFeedViewController.scrollView)
        
        movingImageView.frame = globalFrame
        movingImageView.image = newsFeedViewController.selectedImageView.image
        movingImageView.clipsToBounds = newsFeedViewController.selectedImageView.clipsToBounds
        movingImageView.contentMode = newsFeedViewController.selectedImageView.contentMode
        containerView.addSubview(movingImageView)
        
        photoViewController.view.alpha = 0
        photoViewController.photoView.alpha = 0
        newsFeedViewController.selectedImageView.alpha = 0

        UIView.animateWithDuration(duration, animations: {
            photoViewController.view.alpha = 1
            movingImageView.frame = photoViewController.photoView.frame
            movingImageView.image = photoViewController.photoView.image
            movingImageView.clipsToBounds = photoViewController.photoView.clipsToBounds
            }) { (finished: Bool) -> Void in
                photoViewController.photoView.alpha = 1
                newsFeedViewController.selectedImageView.alpha = 1
                movingImageView.removeFromSuperview()
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let newsFeedViewController = toViewController as! NewsFeedViewController
        let photoViewController = fromViewController as! PhotoViewController
        let movingImageView = UIImageView()
        var newsGlobalFrame = CGRect()
        var photoGlobalFrame = CGRect()
        photoGlobalFrame = containerView.convertRect(photoViewController.photoView.frame, fromView: photoViewController.scrollView)
        newsGlobalFrame = containerView.convertRect(newsFeedViewController.selectedImageView.frame, fromView: newsFeedViewController.scrollView)
        movingImageView.contentMode = photoViewController.photoView.contentMode
        
        photoViewController.photoView.alpha = 0
        newsFeedViewController.selectedImageView.alpha = 0
        
        movingImageView.frame = photoGlobalFrame
        movingImageView.image = photoViewController.photoView.image
        movingImageView.clipsToBounds = photoViewController.photoView.clipsToBounds
        containerView.addSubview(movingImageView)

        UIView.animateWithDuration(duration, animations: {
            photoViewController.view.alpha = 0
            movingImageView.frame = newsGlobalFrame
            movingImageView.image = newsFeedViewController.selectedImageView.image
            movingImageView.clipsToBounds = newsFeedViewController.selectedImageView.clipsToBounds
            }) { (finished: Bool) -> Void in
                photoViewController.photoView.alpha = 1
                newsFeedViewController.selectedImageView.alpha = 1
                movingImageView.removeFromSuperview()
                self.finish()

        }
    }
}
