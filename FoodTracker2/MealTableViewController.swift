//
//  MealTableViewController.swift
//  FoodTracker2
//
//  Created by Khuất Dũng on 1/4/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    //MARK: properties
    var meals = [Meal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let saveMeals = loadMeals() {
            meals += saveMeals
        } else {
            loadSampleMeals()
        }
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            saveMeals() //save meals
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert{
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError ("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        // Configure the cell...
        return cell
    }
    //MARK: Action
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                print("Update")
            }
            else {
                //Add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                print("Add new")
            }
            saveMeals() //save meals
           
        }
    }
    //private method
    private func loadSampleMeals(){
        guard let meal1 = Meal(name: "Pizza", photo: #imageLiteral(resourceName: "pizza"), rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Burger", photo: #imageLiteral(resourceName: "burger"), rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Pho", photo: #imageLiteral(resourceName: "pho"), rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }
        guard let meal4 = Meal(name: "Tao pho", photo: #imageLiteral(resourceName: "taopho"), rating: 2) else {
            fatalError("Unable to instantiate meal4")
        }
        guard let meal5 = Meal(name: "Kem", photo: #imageLiteral(resourceName: "kem"), rating: 5) else {
            fatalError("Unable to instantiate meal5")
        }
        meals += [meal1, meal2, meal3, meal4, meal5]
    }
    private func saveMeals(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successful save", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    private func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    
}
