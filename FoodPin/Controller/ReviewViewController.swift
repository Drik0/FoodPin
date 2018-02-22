//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Gerson Costa on 22/02/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {self.containerView.transform = CGAffineTransform.identity}, completion: nil)
        //UIView.animate(withDuration: 0.3, animations: {self.containerView.transform = CGAffineTransform.identity})
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
