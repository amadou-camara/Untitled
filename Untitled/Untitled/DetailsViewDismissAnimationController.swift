//
//  DetailsViewDismissAnimationController.swift
//  Untitled
//
//  Created by Amadou Camara on 11/22/22.
//

import UIKit

class DetailsViewDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromViewController = transitionContext.viewController(forKey: .from),
           let toViewController = transitionContext.viewController(forKey: .to) {
            let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
            let containerView = transitionContext.containerView
            toViewController.view.frame = finalFrameForVC
            toViewController.view.alpha = 0.5
            containerView.addSubview(toViewController.view)
            containerView.sendSubviewToBack(toViewController.view)
            
            if let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false) {
                snapshotView.frame = fromViewController.view.frame
                containerView.addSubview(snapshotView)
                
                fromViewController.view.removeFromSuperview()
                
                UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                    snapshotView.frame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 2, fromViewController.view.frame.size.height / 2)
                    toViewController.view.alpha = 1.0
                } completion: { finished in
                    snapshotView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            }
        }
    }
}
