//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Cuenta de Iñigo on 18/8/21.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meals = [Meal]()    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            // Load the sample data.
            loadSampleMeals()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    //MARK: Actions

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveMeals()
        }
    }

    //MARK: Private Methods
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadSampleMeals() {
        // Load images
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        // Create meals and add them to the list
        guard let meal1 = Meal(name: "Sushi", cooking: "Strain 2 cups (400 g) of sushi rice under running water. Add water and rice to a saucepan in a 3:2 ratio. Cook the rice for 10 minutes after the water boils. Mix a small amount of salt, sugar, and rice vinegar together. Arrange the rice onto a cooking tray or bowl so it can cool. Mix the vinegar solution into the cooling rice to give it flavor.\nSelect raw tuna or salmon for an authentic sushi roll. Go for cooked eel or crab if you don’t like raw fish. Rub oily fish with sea salt and vinegar to enhance their flavor. Use vegetables like cucumbers and carrots to add texture to your roll. Choose crab and tuna without bits of shell or sinew. Chop fresh fish into 4 by 0.25 in (10.16 by 0.64 cm) long strips. Cut fresh vegetables in thin, vertical slices. Slice fresh avocado into 0.25 in (0.64 cm) thick pieces.\nLay 1 piece of nori onto a bamboo mat. Layer ½ to 1 cup (100-200 g) of sushi rice over the nori sheet. Arrange your ingredients lengthwise on top of the rice. Roll up the bamboo mat so only 0.25 to 1 inch (0.64 to 2.54 cm) of nori is visible. Squeeze the top and sides of the bamboo mat to form the sushi roll. Unroll the bamboo and remove the sushi. Slice the sushi into 6 equally-sized pieces. ", ingredients:"2 cups (400 g) of sushi rice\n3 cups (710 mL) of cold water\n0.25 cups (59 mL) of rice vinegar\n¼ cup (25 g) of granulated sugar\n1 tsp (5.7 g) of salt\n1 pack of unseasoned nori (seaweed sheets)\nSliced vegetables\nSliced fish or seafood\nPickled ginger (optional)\nWasabi (optional)", photo: photo1, starRating: 4, forkRating: 5, euroRating: 5) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Fuet", cooking:"a", ingredients:"Fuet\nBread (optional)\nCheese (optional)", photo: photo2, starRating: 5, forkRating: 2, euroRating: 2) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Curry", cooking:"c", ingredients:"d", photo: photo3, starRating: 3, forkRating: 5, euroRating: 4) else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3]
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.starRatingControl.rating = meal.starRating
        cell.forkRatingControl.rating = meal.forkRating
        cell.euroRatingControl.rating = meal.euroRating
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
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
    
    private func loadMeals() -> [Meal]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    
}
