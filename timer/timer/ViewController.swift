//
//  ViewController.swift
//  timer
//
//  Created by Maya Wong on 2023-01-23.
//

import UIKit

class ViewController: UIViewController {

    //these are attributed connected
    //clicked left most icon above iphone and clicked editor tab/assistant
    //then drag right block attribute to this interface
    
    var timer:Timer = Timer()
    var count:Int = 0
    @objc var timerCount:Bool = false
    
    @IBOutlet weak var ResetBtn: UIButton!
    @IBOutlet weak var StartBtn: UIButton!
    @IBOutlet weak var TimerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        StartBtn.setTitleColor(UIColor.green, for: .normal)
    }

    @IBAction func ResetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you wanna reset the timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: {(_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: {(_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeString(sec: 0, min: 0, hour: 0)
            self.StartBtn.setTitle("START", for: .normal)
            self.StartBtn.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        if (timerCount){
            timerCount = false
            timer.invalidate()
            StartBtn.setTitle("START", for: .normal)
            StartBtn.setTitleColor(UIColor.green, for: .normal)
        }
        else{
            timerCount = true
            StartBtn.setTitle("STOP", for: .normal)
            StartBtn.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setter: timerCount), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeString(sec: time.0, min: time.1, hour: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds:Int) -> (Int, Int, Int){
        //seconds, minutes, hours
        return ((seconds/3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    func makeString(sec:Int, min:Int, hour:Int) -> String {
        var timeString = " "
        timeString += String(format: "%02d", hour)
        timeString += String(format: "%02d", min)
        timeString += String(format: "%02d", sec)
        return timeString
    }
}

