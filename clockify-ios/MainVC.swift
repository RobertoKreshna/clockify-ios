//
//  MainVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 08/10/23.
//

import UIKit
import LZViewPager

class MainVC: UIViewController {
    
    @IBOutlet weak var contentView: LZViewPager!
    
    var currentUser: User?
    private var subControllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
        customizeViewPager()
    }
    
    func customizeBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func customizeViewPager(){
        contentView.delegate = self
        contentView.dataSource = self
        contentView.hostController = self
        addVCToSubControllers()
    }
    
    func addVCToSubControllers(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timerVC = storyboard.instantiateViewController(withIdentifier: "TimerVC") as! TimerVC
        timerVC.currentUser = currentUser
        timerVC.title = "TIMER"
        let activityVC = storyboard.instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
        activityVC.currentUser = currentUser
        activityVC.title = "ACTIVITY"
        subControllers = [timerVC, activityVC]
        contentView.reload()
    }
}

//MARK: View Pager Methods and UI Customization

extension MainVC : LZViewPagerDelegate, LZViewPagerDataSource {
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "NunitoSans7pt-Bold", size: 14)
        button.setTitleColor(.brandAccentDisbaled, for: .normal)
        button.setTitleColor(.brandYellow, for: .selected)
        return button
    }
    
    func backgroundColorForHeader() -> UIColor {
        return .brandBlue
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return .brandYellow
    }
    
    func widthForIndicator(at index: Int) -> CGFloat {
        return CGFloat(24)
    }
}

