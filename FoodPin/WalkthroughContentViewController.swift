//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Gerson Costa on 24/04/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        contentImageView.image = UIImage(named: imageFile)
        contentLabel.text = content
        pageControl.currentPage = index
        
        switch index {
            case 0...1:
                forwardButton.setTitle("NEXT", for: .normal)
            case 2:
                forwardButton.setTitle("DONE", for: .normal)
            default:
                break
        }
    }
    
    @IBAction func forwardButtonTapped(sender: UIButton) {
        switch index {
            case 0...1:
                let pageViewController = parent as! WalkthroughPageViewController
                pageViewController.forward(index: index)
            case 2:
                dismiss(animated: true, completion: nil)
            default:
                break
        }
    }
   
}
