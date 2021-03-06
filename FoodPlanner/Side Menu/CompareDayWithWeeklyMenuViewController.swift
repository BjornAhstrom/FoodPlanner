//
//  CompareDayWithWeeklyMenuViewController.swift
//  FoodPlanner
//
//  Created by Björn Åhström on 2019-03-20.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit
import Firebase

class CompareDayWithWeeklyMenuViewController: UIViewController {
    var mealOfTheDayName: String = ""
    var mealOfTheDayID: String = ""
    
    //private let mealOfTheDaySegueId = "mealOfTheDaySegue"
    private let mealOfTheDayId = "mealOfTheDayId"
    private let mealOfTheDay = "mealOfTheDay"
    
    var db: Firestore!
    var foodMenu = [DishAndDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        getWeeklyMenuFromFireStore()
        
        // NotificationCenter.default.addObserver(self, selector: #selector(goToMealOfTheDay), name: NSNotification.Name( "mealOfTheDay"), object: nil)
    }
    
    func getWeeklyMenuFromFireStore() {
        db.collection("users").document().collection("weeklyMenu").getDocuments() {
            (querySnapshot, error) in
            
            if let error = error {
                print("Error getting document \(error)")
            } else {
                guard let snapshot = querySnapshot else {
                    return
                }
                for document in snapshot.documents {
                    let weeklyMenu = DishAndDate(snapshot: document)
                    
                    let date1 = Date()
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateStyle = .long
                    let stringOutput1 = dateFormatter1.string(from: date1)
                    
                    let date2 = weeklyMenu.date
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateStyle = .long
                    let stringOutput2 = dateFormatter2.string(from: date2)
                    
                    
                    if stringOutput1 == stringOutput2 {
                        self.mealOfTheDayName = String(weeklyMenu.dishName)
                        self.mealOfTheDayID = String(weeklyMenu.idFromDish)
                        self.goToMeal()
                        // Go To MealOfTheDayController
                        NotificationCenter.default.post(name: NSNotification.Name(self.mealOfTheDayId), object: nil)
                    } else {
                        //Go to selectRandomDishesController
                        print("Error getting saved")
                        
                    }
                    
                    self.foodMenu.append(weeklyMenu)
                }
            }
        }
    }
    
    func goToMeal() {
        if let mealOfTheDay = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: mealOfTheDay) as? MealOfDayViewController {
            
            mealOfTheDay.mealOfTheDayName = mealOfTheDayName
            
            let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
            mealOfTheDay.modalTransitionStyle = modalStyle
            self.present(mealOfTheDay, animated: true, completion: nil)
        }
    }
    
    func goToSelectRandomDish() {
        if let selectRandomDish = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: mealOfTheDay) as? SelectRandomDishesViewController {
            
            let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
            selectRandomDish.modalTransitionStyle = modalStyle
            self.present(selectRandomDish, animated: true, completion: nil)
        }
    }
}
