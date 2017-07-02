//
//  FoodTracker2Tests.swift
//  FoodTracker2Tests
//
//  Created by Khuất Dũng on 1/3/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import XCTest
@testable import FoodTracker2

class FoodTracker2Tests: XCTestCase {
    
   //MARK: Meal class tests
    
    //Confirm that Meal initializer return a Meal object when passed valid parameters
    func testMealInitializationSucceeds(){
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        //Highet positive rating
        let positiveRating = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRating)
        
    }
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitializationFails(){
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        //Empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        //Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
}
