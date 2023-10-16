//
//  RegisterVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 06/10/23.
//

import UIKit

class RegisterVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let authController = AuthController()
    
    var currentUser: User?
    
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
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back-blue"),
            style: .plain,
            target: self,
            action: #selector(handleBackButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .brandBlue
    }
    
    @objc private func handleBackButtonTapped() {
       navigationController?.popViewController(animated: true)
    }
    
    func customizeButton(){
        createButton.backgroundColor = .clear
        createButton.applyGradient(
            colours: [UIColor.brandLightBlue, UIColor.brandLightBlueDisabled],
            cornerRadius: 16
        )
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
    
    @IBAction func createPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let pw = pwTextfield.text, let confirmPw = confirmPwTextfield.text{
             currentUser = authController.signUp(
                context,
                email:email,
                password: pw,
                confirmPassword: confirmPw
            )
            if(currentUser != nil){
                self.performSegue(withIdentifier: "registerToMain", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "registerToMain"){
            let destinationVC = segue.destination as! MainVC
            destinationVC.currentUser = currentUser
        }
    }
    
}
