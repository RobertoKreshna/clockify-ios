//
//  MainVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 08/10/23.
//

import UIKit

class MainVC: UIViewController {
    var currentUser: User?
    
    private lazy var TimerVC: TimerVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "TimerVC") as! TimerVC
        vc.currentUser = currentUser
        self.addChild(vc)
        return vc
    }()
    
    private lazy var ActivityVC: ActivityVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
        vc.currentUser = currentUser
        self.addChild(vc)
        return vc
    }()
    
    @IBOutlet weak var timerTab: UIButton!
    @IBOutlet weak var activityTab: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
        setupTab()
    }
    
    func customizeBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setupTab(){
        timerTab.setTitleColor(.brandAccentDisbaled, for: .normal)
        activityTab.setTitleColor(.brandAccentDisbaled, for: .normal)
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.text = "TIMER"
        updateView(button)
    }
    
    @IBAction func updateView(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text{
            initNewVC()
            if buttonTitle == "TIMER" {
                updateTitle(isTimer: true)
                remove(asChildViewController: ActivityVC)
                add(asChildViewController: TimerVC)
            } else if buttonTitle == "ACTIVITY"{
                updateTitle(isTimer: false)
                remove(asChildViewController: TimerVC)
                add(asChildViewController: ActivityVC)
            }
        }
    }
    
    private func initNewVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        ActivityVC = storyboard.instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
        ActivityVC.currentUser = currentUser
        TimerVC = storyboard.instantiateViewController(withIdentifier: "TimerVC") as! TimerVC
        TimerVC.currentUser = currentUser
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        self.contentView.addSubview(viewController.view)
        viewController.view.frame = contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func updateTitle(isTimer: Bool){
        timerTab.configuration?.baseForegroundColor = isTimer ? .brandYellow : .brandAccentDisbaled
        activityTab.configuration?.baseForegroundColor = isTimer ? .brandAccentDisbaled : .brandYellow
    }
}

