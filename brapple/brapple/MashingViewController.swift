//
//  MashingViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class MashingViewController: UIViewController {
    
    var isTimerRunning = false
    var timer = Timer()
    var timeInSeconds = 0

    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeInSeconds = 10 // TODO Replace with the persisted value from the recipe
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        if self.isTimerRunning == false {
            self.isTimerRunning = true
            runTimer()
        } else {
            self.isTimerRunning = false
            sender.setTitle("Timer starten", for: .normal)
            self.timer.invalidate()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if self.timeInSeconds < 1 {
            self.timer.invalidate()
            self.timerButton.setTitle("Timer starten", for: .normal)
            // TODO Move on the the next step of the mashing process
        } else {
            self.timeInSeconds -= 1
            self.timerButton.setTitle(timeString(time: TimeInterval(self.timeInSeconds)), for: .normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
