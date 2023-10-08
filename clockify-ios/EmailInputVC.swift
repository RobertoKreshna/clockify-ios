//
//  ViewController.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 06/10/23.
//

import UIKit

class EmailInputVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signinButton.applyGradient(colors: [UIColor.brandLightBlue.cgColor, UIColor.brandLightBlueDisabled.cgColor])
        emailTextField.addBottomBorderWithColor(color: .white, width: 1)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    @IBAction func createNewAccountPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToLogin"){
            let destinationVC = segue.destination as! LoginVC
            destinationVC.email = emailTextField.text
        }
    }
    
}

