//
//  LoginVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 06/10/23.
//

import UIKit

class LoginVC: UIViewController {
    var email: String?
    @IBOutlet var passwordTextfield: UITextField!
    
    var pwVisible = false
    @IBOutlet weak var pwTextfieldIcon: UIButton!
    
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextField()
        customizeBackButton()
        customizeOkButton()
    }
    
    func customizeOkButton(){
        okButton.applyGradient(colors: [UIColor.brandLightBlue.cgColor, UIColor.brandLightBlueDisabled.cgColor])
    }
    
    func customizeTextField() {
        passwordTextfield.addBottomBorderWithColor(color: .brandBlue, width: 1)
    }
    
    func customizeBackButton(){
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-blue")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-blue")
        navigationController?.navigationBar.tintColor = .brandBlue
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }

    @IBAction func pwIconPressed(_ sender: UIButton) {
        pwVisible = !pwVisible
        passwordTextfield.isSecureTextEntry = !passwordTextfield.isSecureTextEntry
        if passwordTextfield.isSecureTextEntry {
                if let image = UIImage(named: "eye-off") {
                    sender.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(named: "eye-on") {
                    sender.setImage(image, for: .normal)
                }
            }
        
    }
    
}
