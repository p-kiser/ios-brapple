//
//  FermentationViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit
import EventKit

class FermentationViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fermView: UITextView!
    @IBOutlet weak var matView: UITextView!
    
    
    // time in days
    let fermentation: Int = recipe!.Fermentation.Weeks
    let maturation : Int = recipe!.Maturation.Duration +  recipe!.Fermentation.Weeks
    
    // calendar entry titles
    let fermText = "Gärung beendet: "
    let matText = "Flaschengärung beendet: "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // display beer name and liters
        topLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
        
        // set texts on labels
        nameLabel.text = recipe!.Name
        fermView.text = ""
        fermView.text.append(fermText + "\n")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        fermView.text.append(dateFormatter.string(from: getDate(days: fermentation)))
        matView.text = ""
        matView.text.append(matText + "\n")
        matView.text.append(dateFormatter.string(from: getDate(days: maturation)))
    }
    
    @IBAction func onCalendarButtonPressed(_ sender: UIButton) {
        setCalendarEntry(date: getDate(days: fermentation), name: fermText + recipe!.Name)
        sender.isEnabled = false
    }
    @IBAction func matButtPressed(_ sender: UIButton) {
         setCalendarEntry(date: getDate(days: maturation), name: matText + recipe!.Name)
        sender.isEnabled = false
    }
    
    
    func setCalendarEntry(date: Date, name : String) {
        let eventStore : EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) {(granted, error) in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                let event : EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = name
                event.startDate = date
                event.endDate = date
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("Failed to save event with error : \(error)")
                }
                
                let eventSavedAlert = UIAlertController(title: "Kalendereintrag hinzugefügt", message: nil, preferredStyle: .alert)
                eventSavedAlert.addAction(UIAlertAction(title: "Verstanden", style: .default, handler: nil))
                self.present(eventSavedAlert, animated: true)
                print("Saved Event")
            } else {
                print("Failed to save event with error : \(String(describing: error)) or access not granted")
            }
        }
    }
    
    func getDate(days : Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        let currentDate = Date()
        let date = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        return date!;
    }
}
