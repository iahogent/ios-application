//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Cuenta de Iñigo on 17/8/21.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var type: Int = 0 {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var size: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var count: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    private func setupButtons() {
        
        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundleStar = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundleStar, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundleStar, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundleStar, compatibleWith: self.traitCollection)
        
        let bundleFork = Bundle(for: type(of: self))
        let filledFork = UIImage(named: "filledFork", in: bundleFork, compatibleWith: self.traitCollection)
        let emptyFork = UIImage(named:"emptyFork", in: bundleFork, compatibleWith: self.traitCollection)
        let highlightedFork = UIImage(named:"highlightedFork", in: bundleFork, compatibleWith: self.traitCollection)
        
        let bundleEuro = Bundle(for: type(of: self))
        let filledEuro = UIImage(named: "filledEuro", in: bundleEuro, compatibleWith: self.traitCollection)
        let emptyEuro = UIImage(named:"emptyEuro", in: bundleEuro, compatibleWith: self.traitCollection)
        let highlightedEuro = UIImage(named:"highlightedEuro", in: bundleEuro, compatibleWith: self.traitCollection)
        
        switch type {
        case 0:
            for index in 0..<count {
                // Create the button
                let button = UIButton()
                
                // Set the button images
                button.setImage(emptyStar, for: .normal)
                button.setImage(filledStar, for: .selected)
                button.setImage(highlightedStar, for: .highlighted)
                button.setImage(highlightedStar, for: [.highlighted, .selected])
                
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                
                // Set accessibility label
                button.accessibilityLabel = "Set \(index + 1) star rating"
                
                // Setup the button action
                button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                // Add the new button to the rating button array
                ratingButtons.append(button)
            }
        case 1:
            for index in 0..<count {
                // Create the button
                let button = UIButton()
                
                // Set the button images
                button.setImage(emptyFork, for: .normal)
                button.setImage(filledFork, for: .selected)
                button.setImage(highlightedFork, for: .highlighted)
                button.setImage(highlightedFork, for: [.highlighted, .selected])
                
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                
                // Set accessibility label
                button.accessibilityLabel = "Set \(index + 1) fork rating"
                
                // Setup the button action
                button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                // Add the new button to the rating button array
                ratingButtons.append(button)
            }
        case 2:
            for index in 0..<count {
                // Create the button
                let button = UIButton()
                
                // Set the button images
                button.setImage(emptyEuro, for: .normal)
                button.setImage(filledEuro, for: .selected)
                button.setImage(highlightedEuro, for: .highlighted)
                button.setImage(highlightedEuro, for: [.highlighted, .selected])
                
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                
                // Set accessibility label
                button.accessibilityLabel = "Set \(index + 1) Euro rating"
                
                // Setup the button action
                button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                // Add the new button to the rating button array
                ratingButtons.append(button)
            }
        default:
            break
        }
        updateButtonSelectionStates()
    }
    
}
