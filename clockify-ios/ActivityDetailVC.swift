//
//  ActivityDetailVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 16/10/23.
//

import UIKit

class ActivityDetailVC: UIViewController {
    
    var activity: Activity?
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
        populateLabel()
        customizeButton()
    }
    
    func customizeBackButton(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "NunitoSans7pt-Bold", size: 20)!,
        ]
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back-white"), for: .normal)
        backButton.setAttributedTitle(NSAttributedString(
            string: "Detail", attributes: attributes),
            for: .normal
        )
        backButton.tintColor = .brandAccent
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func handleBackButtonTapped() {
       navigationController?.popViewController(animated: true)
    }
    
    func populateLabel(){
        startTimeLabel.text = TimeAndDate.displayTime(date: (activity?.start)!)
        startDateLabel.text = TimeAndDate.displayDate(date: (activity?.start)!)
        endTimeLabel.text = TimeAndDate.displayTime(date: (activity?.end)!)
        endDateLabel.text = TimeAndDate.displayDate(date: (activity?.end)!)
        locationLabel.text = "\((activity?.latitude)!), \((activity?.longitude)!)"
        titleTextView.text = activity?.title
        hourLabel.text = TimeAndDate.getHourFromDuration(duration: (activity?.duration)!)
        minuteLabel.text = TimeAndDate.getMinuteFromDuration(duration: (activity?.duration)!)
        secondLabel.text = TimeAndDate.getSecondFromDuration(duration: (activity?.duration)!)
    }
    
    func customizeButton(){
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
}
