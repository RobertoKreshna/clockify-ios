//
//  RegisterPopupVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 18/10/23.
//

import UIKit

class RegisterPopupVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var outsideButton: UIButton!
    
    var outsideButtonTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
        customizePopup()
    }
    
    func customizeBackButton(){
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func customizePopup(){
        contentView.layer.cornerRadius = 12
    }
    
    @IBAction func outsideButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true){
            self.outsideButtonTapped!()
        }
    }
}
