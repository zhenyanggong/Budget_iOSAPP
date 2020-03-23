//
//  MoneyTrackViewController.swift
//  try
//
//  Created by Junyi Zhang on 3/11/20.
//  Copyright © 2020 Junyi Zhang. All rights reserved.
//

import UIKit
import UserNotifications

class MoneyTrackViewController: UIViewController, canReceive {
    

    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    var budgetValue = 0.0
    var startDateValue = Date()
    var endDateValue = Date()
    var spending = 0.0
    func passDataBack(data: Double) {
        spending = data
        budgetValue -= spending
        AmountLabel.text = "\(budgetValue)"
        if budgetValue < 20 {
            AmountLabel.textColor = UIColor.red
            AmountLabel.font = AmountLabel.font.withSize(60)
            let content = UNMutableNotificationContent()
            content.title = "Circle Pay Warning"
            content.body = "You have \(budgetValue) left"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "notifidentifier", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AmountLabel.text = "\(budgetValue)"
        print(endDateValue)
        if endDateValue < Date() {
            createAlert(title: "End of Date", message: "You should set a new budget.")
        }
    }
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "toMoneySpent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoneySpent" {
            let vc = segue.destination as! MoneySpentViewController
            vc.delegate = self
        }
        
    }
 
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.performSegue(withIdentifier: "endSession", sender: self)
            
        
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

}
