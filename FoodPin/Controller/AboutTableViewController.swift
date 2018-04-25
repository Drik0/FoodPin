//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Gerson Costa on 25/04/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = ["Leave Feedback", "Follow Us"]
    var sectionContent = [["Rate us on App Store", "Tell us your feedback"],
                          ["Twitter", "Facebook", "Pinterest"]]
    var links = ["https://twitter.com/appcodamobile", "https://facebook.com/appcodamobile", "https://www.pinterest.com/appcoda/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionContent[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: "http://www.apple.com/itunes/charts/paid-apps/") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else if indexPath.row == 1 {
                    performSegue(withIdentifier: "showWebView", sender: self)
                }
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
