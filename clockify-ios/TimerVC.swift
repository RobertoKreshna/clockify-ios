//
//  TimerVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 10/10/23.
//

import UIKit
import CoreLocation

class TimerVC: UIViewController {
    
    var timer = Timer()
    var counterInSeconds = 0
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var startStack: UIStackView!
    @IBOutlet weak var stopResetStack: UIStackView!
    @IBOutlet weak var saveDeleteStack: UIStackView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var locationStack: UIStackView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton()
        customizeTextView()
        initialhideStacks()
        customizeLocationStack()
        textView.delegate = self
        getCurrentLocation()
    }
    
    func getCurrentLocation(){
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        locManager.delegate = self
    }
    
    func customizeButton(){
        startButton.backgroundColor = .clear
        startButton.applyGradient(
            colours: [.brandLightBlue, .brandLightBlueDisabled],
            cornerRadius: 16
        )
        stopButton.backgroundColor = .clear
        stopButton.applyGradient(
            colours: [.brandLightBlue, .brandLightBlueDisabled],
            cornerRadius: 16
        )
        resetButton.backgroundColor = .clear
        resetButton.applyGradient(
            colours: [.white, .white],
            cornerRadius: 16
        )
        saveButton.backgroundColor = .clear
        saveButton.applyGradient(
            colours: [.brandLightBlue, .brandLightBlueDisabled],
            cornerRadius: 16
        )
        deleteButton.backgroundColor = .clear
        deleteButton.applyGradient(
            colours: [.white, .white],
            cornerRadius: 16
        )
    }
    
    func customizeTextView(){
        textView.layer.cornerRadius = 8
    }
    
    func customizeLocationStack(){
        locationStack.layer.cornerRadius = 16
    }
    
    func initialhideStacks(){
        stopResetStack.isHidden = true
        saveDeleteStack.isHidden = true
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        updateLabel(type: "Start")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        startStack.isHidden = true
        stopResetStack.isHidden = false
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        timer.invalidate()
        updateLabel(type: "End")
        stopResetStack.isHidden = true
        saveDeleteStack.isHidden = false
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        timer.invalidate()
        resetAllLabel()
        resetTextView()
        resetCounter()
        stopResetStack.isHidden = true
        startStack.isHidden = false
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        resetAllLabel()
        resetTextView()
        resetCounter()
        saveDeleteStack.isHidden = true
        startStack.isHidden = false
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        resetAllLabel()
        resetTextView()
        resetCounter()
        saveDeleteStack.isHidden = true
        startStack.isHidden = false
    }
    
    func updateLabel(type:String){
        if type == "Start"{
            startTimeLabel.text = TimeAndDate.getcurrentTime()
            startDateLabel.text = TimeAndDate.getcurrentDate()
        } else if type == "End"{
            endTimeLabel.text = TimeAndDate.getcurrentTime()
            endDateLabel.text = TimeAndDate.getcurrentDate()
        }
    }
    
    func resetAllLabel(){
        startTimeLabel.text = "-"
        startDateLabel.text = "-"
        endTimeLabel.text = "-"
        endDateLabel.text = "-"
        hoursLabel.text = "00"
        minutesLabel.text = "00"
        secondsLabel.text = "00"
    }
    
    func resetTextView(){
        textView.text = "Write your activity here ..."
        textView.textColor = UIColor.brandAccentDisbaled
    }
    
    func resetCounter(){
        counterInSeconds = 0
    }
    
    @objc func timerAction() {
        counterInSeconds += 1
        secondsLabel.text = StringExtension.padZeroOnLeft(
            s: counterInSeconds % 60,
            length: 2
        )
        minutesLabel.text = StringExtension.padZeroOnLeft(
            s: (counterInSeconds / 60) % 60,
            length: 2
        )
        hoursLabel.text = StringExtension.padZeroOnLeft(
            s: counterInSeconds / 3600,
            length: 2
        )
    }
    
}


extension TimerVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.brandAccentDisbaled {
            textView.text = nil
            textView.textColor = UIColor.brandBlue
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your activity here ..."
            textView.textColor = UIColor.brandAccentDisbaled
        }
    }
}

extension TimerVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            locationLabel.text = "\(lat), \(long)"
        }
    }
}
