//
//  HopReproducingViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class HopReproducingViewController: UIViewController {
  
    // Time in seconds
    var steps = recipe!.Hopping
    
    var n : Int = 0
    var labels : [UILabel] = []
    
    var isTimerRunning = false
    var timer = Timer()
    var timeInSeconds = 0
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display beer name and liters
        topLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
        
        // set shorter times for debuggin
        if debug {
            for (i,_) in steps.enumerated() {
                steps[i].Time = 3
            }
        }
        
        //addLabels()
        for (i, s) in steps.enumerated() {
            let label = UILabel(frame: CGRect(x: -2, y: 200+i*48, width: 380, height: 50))
            label.text = String(format:"%@ beigeben und %i Minuten warten", s.Name, s.Time)
            label.textAlignment = .center
            label.layer.borderWidth = 2.0
            label.layer.zPosition = 0
            view.addSubview(label)
            labels.append(label)
        }
        updateHighlight()
    }
    
    func updateHighlight() {
        for (i,label) in labels.enumerated() {
            if i == n {
                view.bringSubviewToFront(label)
                label.textColor = UIColor.green
                label.layer.borderColor = UIColor.green.cgColor
            } else {
                label.textColor = UIColor.black
                label.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
    
        NSLog("timer button pressed")
        if isTimerRunning == false {
            isTimerRunning = true
            runTimer()
        } else {
            isTimerRunning = false
            sender.setTitle("Timer starten", for: .normal)
            timer.invalidate()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if self.timeInSeconds < 1 {
            self.timer.invalidate()
            n += 1
            if n >= steps.count {
                timerButton.isEnabled = false
                timerButton.backgroundColor = UIColor.gray
            } else  {
                self.timeInSeconds = steps[n].Time
                self.timerButton.setTitle("Timer starten", for: .normal)
                self.isTimerRunning = false
            }
            updateHighlight()
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
