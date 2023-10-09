//
//  MainVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 08/10/23.
//

import UIKit

class MainVC : UIViewController {
    
    var currentUser: User? {
        didSet{
            print(currentUser?.email ?? "Email")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
    }
    
    func customizeBackButton(){
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
}
