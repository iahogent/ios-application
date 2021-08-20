//
//  Meal.swift
//  FoodTracker
//
//  Created by Cuenta de Iñigo on 17/8/21.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var cooking: String
    var ingredients: String
    var photo: UIImage?
    var starRating: Int
    var forkRating: Int
    var euroRating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")  
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let cooking = "cooking"
        static let ingredients = "ingredients"
        static let photo = "photo"
        static let starRating = "starRating"
        static let forkRating = "forkRating"
        static let euroRating = "euroRating"
    }
    
    //MARK: Initialization
    
    init?(name: String, cooking: String, ingredients: String, photo: UIImage?, starRating: Int, forkRating: Int, euroRating: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // All the rating must be between 0 and 5 inclusively
        guard (starRating >= 0) && (starRating <= 5) else {
            return nil
        }
        
        guard (forkRating >= 0) && (forkRating <= 5) else {
            return nil
        }
        
        guard (euroRating >= 0) && (euroRating <= 5) else {
            return nil
        }
        
        // Initialization should fail if there is no name or if any rating is negative.
        if name.isEmpty || starRating < 0 || forkRating < 0 || euroRating < 0 {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.cooking = cooking
        self.ingredients = ingredients
        self.photo = photo
        self.starRating = starRating
        self.forkRating = forkRating
        self.euroRating = euroRating
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(cooking, forKey: PropertyKey.cooking)
        aCoder.encode(ingredients, forKey: PropertyKey.ingredients)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(starRating, forKey: PropertyKey.starRating)
        aCoder.encode(forkRating, forKey: PropertyKey.forkRating)
        aCoder.encode(euroRating, forKey: PropertyKey.euroRating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let cooking = aDecoder.decodeObject(forKey: PropertyKey.cooking) as? String else{
            os_log("Unable to decode the cooking instructions for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let ingredients = aDecoder.decodeObject(forKey: PropertyKey.ingredients) as? String else{
            os_log("Unable to decode the ingredients for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        

        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let starRating = aDecoder.decodeInteger(forKey: PropertyKey.starRating)
        let forkRating = aDecoder.decodeInteger(forKey: PropertyKey.forkRating)
        let euroRating = aDecoder.decodeInteger(forKey: PropertyKey.starRating)
        
        
        
        // Must call designated initializer.
        self.init(name: name, cooking: cooking, ingredients: ingredients, photo: photo, starRating: starRating, forkRating: forkRating, euroRating: euroRating)
        
    }

}
