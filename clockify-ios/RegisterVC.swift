//
//  RegisterVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 06/10/23.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    var pwVisible = false
    @IBOutlet weak var pwIcon: UIButton!
    @IBOutlet weak var pwTextfield: UITextField!
    
    var confirmPwVisible = false
    @IBOutlet weak var confirmPwTextfield: UITextField!
    @IBOutlet weak var confirmPwIcon: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextfield()
        customizeBackButton()
        customizeButton()
    }
    
    func customizeTextfield(){
        emailTextField.addBottomBorderWithColor(color: .brandBlue, width: 1)
        pwTextfield.addBottomBorderWithColor(color: .brandBlue, width: 1)
        confirmPwTextfield.addBottomBorderWithColor(color: .brandBlue, width: 1)
    }

    func customizeBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-blue")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-blue")
        navigationController?.navigationBar.tintColor = .brandBlue
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
    func customizeButton(){
        createButton.applyGradient(colors: [UIColor.brandLightBlue.cgColor, UIColor.brandLightBlueDisabled.cgColor])
    }
    
    @IBAction func pwIconPressed(_ sender: UIButton) {
        pwVisible = !pwVisible
        pwTextfield.isSecureTextEntry = !pwTextfield.isSecureTextEntry
        if pwTextfield.isSecureTextEntry {
                if let image = UIImage(named: "eye-off") {
                    sender.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(named: "eye-on") {
                    sender.setImage(image, for: .normal)
                }
            }
    }
    
    @IBAction func confirmPwIconPressed(_ sender: UIButton) {
        confirmPwVisible = !confirmPwVisible
        confirmPwTextfield.isSecureTextEntry = !confirmPwTextfield.isSecureTextEntry
        if confirmPwTextfield.isSecureTextEntry {
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
