//
//  ActivityDetailVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 16/10/23.
//

import UIKit

class ActivityDetailVC: UIViewController {
    
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
    }
    
    func customizeBackButton(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back-white"),
            style: .plain,
            target: self,
            action: #selector(handleBackButtonTapped)
        )
    }
    
    @objc private func handleBackButtonTapped() {
       navigationController?.popViewController(animated: true)
    }
    
}
