//
//  Ingredients.swift
//  FoodPlanner
//
//  Created by Björn Åhström on 2019-03-07.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Ingredient : Equatable {
    var ingredientsTitle: String
    var amount: Int = 0
    var unit: String
    var ingredientID: String
    //Bool
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.ingredientsTitle == rhs.ingredientsTitle
        
    }
    
    init(ingredientsTitle: String, amount: Int, unit: String) {
        self.ingredientsTitle = ingredientsTitle
        self.amount = amount
        self.unit = unit
        ingredientID = ""
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String : Any]
        ingredientsTitle = snapshotValue["ingredientName"] as! String
        amount = snapshotValue["amount"] as! Int
        unit = snapshotValue["unit"] as! String
        ingredientID = snapshot.documentID
    }
    
    func toAny() -> [String : Any] {
        return ["ingredientName" : ingredientsTitle, "unit" : unit, "amount" : amount]
    }
    
}
