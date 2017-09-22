//
//  UserDetailViewController.swift
//  BabylonKeyArchiver
//
//  Created by Aditya Agung Putra on 9/19/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var streetSuiteLabel: UILabel!
    @IBOutlet weak var cityZipcodeLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toEditUser))
    }

    override func viewWillAppear(_ animated: Bool) {
        setUserView()
    }
    
    private func setUserView(){
        if let user = user {
            title = user.name
            emailLabel.text = "Email: \(user.email ?? "")"
            websiteLabel.text = "Website: \(user.website ?? "")"
            streetSuiteLabel.text = "\(user.address?.street ?? "") \(user.address?.suite ?? "")"
            cityZipcodeLabel.text = "\(user.address?.city ?? "") \(user.address?.zipcode ?? "")"
        }
    }
    
    @objc private func toEditUser(){
        let editUserVC = EditUserViewController()
        editUserVC.user = user
        navigationController?.pushViewController(editUserVC, animated: true)
    }
}
