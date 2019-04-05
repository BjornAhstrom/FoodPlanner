//
//  ThemeProtocol.swift
//  FoodPlanner
//
//  Created by Björn Åhström on 2019-02-26.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var fontForLabels: String { get }
    var textColorForLabels: UIColor { get }
    var fontForButtons: String { get }
    var colorForButtons: UIColor { get }
    var colorForBorder: UIColor { get }
    var textColorForButtons: UIColor { get }
    var textColor: UIColor { get }
    
    // General
    var navigationbarTextColor: UIColor { get }
    
    // Sidebar menu
    var backgroundColorSideMenu: UIColor { get }
    var sideBarButtonColor: UIColor { get }
    var sideBarButtonFont: UIFont { get }
    var sideBarButtonTextColor: UIColor { get }
    var sideBarButtonBorderColor: UIColor { get }
    
    // Meal of the day
    var backgroundColorMealOfTheDay: UIColor { get }
    var mealOfTheDayLabelFont: UIFont { get }
    var mealOfTheDayLabelTextColor: UIColor { get }
    var dateLabelFont: UIFont { get }
    var dateLabelTextColor: UIColor { get }
    var foodNameLabelFont: UIFont { get }
    var foodNameLabelTextColor: UIColor { get }
    var recipeButtonBackgroundColor: UIColor { get }
    var recipeButtonTextColor: UIColor { get }
    var recipeButtonFont: UIFont { get }
    var recipeButtonBorderColor: UIColor { get }
    
    // Dishes view controller
    var backgroundColorInDishesView: UIColor { get }
    var textColorInTableViewInDishesView: UIColor { get }
    var textFontInTableViewInDishesView: UIFont { get }
    
    // Show dish view controller
    var backgroundColorShowDishController: UIColor { get }
    var backgroundColorInTableViewAndTextViewInShowDishController: UIColor { get }
    var borderColorInTableViewAndTextViewInShowDishController: UIColor { get }
    var textColorInTableViewAndTextViewInShowDishController: UIColor { get }
    var textFontInTextViewInShowDishController: UIFont { get }
    var textFontInTableViewInShowDishController: UIFont { get }
    var labelFontInShowDishController: UIFont { get }
    var labelTextColorInShowDishController: UIColor { get }
    var dishNameLabelFontInShowDishController: UIFont { get }
    
    // Select random dish view controller
    var backgroundColorSelectRandomDishController: UIColor { get }
    
    // Random weekly menuController
    var backgroundColorRandomWeeklyMenuController: UIColor { get }
    
    // Finished weekly menu controller
    var backgrondColorFinishedWeeklyMenuController: UIColor { get }
}
