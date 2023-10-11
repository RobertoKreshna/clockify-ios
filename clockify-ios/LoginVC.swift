//
//  LoginVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 06/10/23.
//

import UIKit

class LoginVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let authController = AuthController()
    
    var currentUser: User?
    
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
        okButton.backgroundColor = .clear
        okButton.applyGradient(
            colours: [UIColor.brandLightBlue, UIColor.brandLightBlueDisabled],
            cornerRadius: 16
        )
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
    
    @IBAction func okPressed(_ sender: UIButton) {
        if let email = email, let pw = passwordTextfield.text{
             currentUser = authController.logIn(
                context,
                email:email,
                pw: pw
            )
            if(currentUser != nil){
                self.performSegue(withIdentifier: "loginToMain", sender: self)
            }
        }
    }
}
