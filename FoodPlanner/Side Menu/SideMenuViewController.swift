//
//  SideMenuViewController.swift
//  FoodPlanner
//
//  Created by Björn Åhström on 2019-02-26.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoriesTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var shoppingListButton: UIButton!
    @IBOutlet var sidebarButtons: [UIButton]!
    @IBOutlet weak var settingsButton: UIButton!
    
    private let addAndShowDish = "addAndShowDish"
    private let weeklyMenu = "weeklyMenu"
    private let selectRandomDishMenu = "selectRandomDishMenu"
    private let showSideMenu = "showSideMenu"
    private let shoppingList = "shoppingList"
    
    var buttons: [Button] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorFontAndSizeOnButtonsAndLebels()
        buttons = createFourPredefinedButtons()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setColorFontAndSizeOnButtonsAndLebels() {
        for btn in sidebarButtons {
            btn.layer.cornerRadius = 20
            btn.layer.borderColor = Theme.current.sideBarButtonBorderColor.cgColor
            btn.layer.borderWidth = 1
            btn.backgroundColor = Theme.current.colorForButtons
            btn.setTitleColor(Theme.current.sideBarButtonTextColor, for: .normal)
            btn.titleLabel?.font = Theme.current.sideBarButtonFont
        }
        
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 4
        view.layer.backgroundColor = Theme.current.backgroundColorSideMenu.cgColor
        tableView.backgroundColor = Theme.current.backgroundColorSideMenu
        
        addCategoriesTextField.layer.masksToBounds = true
        addCategoriesTextField.layer.cornerRadius = 12
        addCategoriesTextField.layer.borderWidth = 1
        addCategoriesTextField.layer.borderColor = Theme.current.sideBarButtonBorderColor.cgColor
        
        settingsButton.setTitleColor(Theme.current.sideBarButtonTextColor, for: .normal)
    }
    
    @IBAction func addANewButton(_ sender: UIButton) {
        addANewButtonAndSetLabelText()
        view.endEditing(true)
    }
    
    func addANewButtonAndSetLabelText() {
        if addCategoriesTextField.text! == "" {
            alertMessage(titel: "Your button most have a name")
        } else {
            buttons.append(Button(buttonTitle: addCategoriesTextField.text!))
            
            let indexPath = IndexPath(row: buttons.count-1, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            addCategoriesTextField.text! = ""
            //self.hideKeyboard()
        }
    }
    
    func createFourPredefinedButtons() -> [Button] {
        var tempButtons: [Button] = []
        
        let button1 = Button(buttonTitle: "My recipes")
        let button2 = Button(buttonTitle: "My recipes from pictures")
        let button3 = Button(buttonTitle: "My webrecipes")
        let button4 = Button(buttonTitle: "Weekly menu")
        let button5 = Button(buttonTitle: "Create new food menu")
        
        tempButtons.append(button1)
        tempButtons.append(button2)
        tempButtons.append(button3)
        tempButtons.append(button4)
        tempButtons.append(button5)
        
        return tempButtons
    }
    
    @IBAction func shoppingListButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(shoppingList), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(showSideMenu), object: nil)
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let button = buttons[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ButtonCell
        
        cell.setButtonTile(title: button)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView
        cell.backgroundColor = Theme.current.backgroundColorSideMenu
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let destination = UIViewController() as? DishesViewController
        navigationController?.pushViewController(destination!, animated: true)
        
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name(addAndShowDish), object: nil)
        case 1: print("1")
        case 2: print("2")
        case 3: NotificationCenter.default.post(name: NSNotification.Name(weeklyMenu), object: nil)
        case 4: NotificationCenter.default.post(name: NSNotification.Name(selectRandomDishMenu), object: nil)
        default: break
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(showSideMenu), object: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            buttons.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func alertMessage(titel: String) {
        let alert = UIAlertController(title: titel, message: "Pleace try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion:  nil)
    }
}
