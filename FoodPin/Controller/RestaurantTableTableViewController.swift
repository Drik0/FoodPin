//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by Gerson Costa on 01/02/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class RestaurantTableTableViewController: UITableViewController {
    
    var restaurants: [RestaurantMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        //Configure cell
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        if let thumbnailImage = restaurants[indexPath.row].image {
        cell.thumbnailImageView.image = UIImage(data: thumbnailImage as Data)
        }
        cell.accessoryType = restaurants[indexPath.row].isVisited ? .checkmark : .none
        
        return cell
    }


    //Delete data from datasource - ****** Not sure why is still neededed after implementing editActionsForRowAt method ******
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
        }
     
     tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    //Add actions buttons when swipe the cell
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Adds share button
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) -> Void in
            
            let defaultText = "Just checking in at" + self.restaurants[indexPath.row].name!
            
            if let restaurantImage = self.restaurants[indexPath.row].image,
                let imageToShare = UIImage(data: restaurantImage as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)}
            }

        //Adds delete button
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) -> Void in
            
            //Delete the content from datasource
                self.restaurants.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)}
        
        //Change button background color
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Check segue indentifier
        if segue.identifier == "showRestaurantDetail" {
            
            //Retrieve the selected row
            if let indexPath = tableView.indexPathForSelectedRow {
                
                //Set the name of restaurantImage in detailVC, the same of selected row
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }

}
