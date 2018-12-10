//
//  MaturationViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit
import EventKit

class MaturationViewController: UIViewController {

    var maturationDuration : Int = 21 // Days
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCalendarButtonPressed(_ sender: UIButton) {
        let eventStore : EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) {(granted, error) in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                let event : EKEvent = EKEvent(eventStore: eventStore)
                
                var dateComponent = DateComponents()
                dateComponent.day = self.maturationDuration
                let currentDate = Date()
                let date = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                
                event.title = "Reifung beendet"
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
}
