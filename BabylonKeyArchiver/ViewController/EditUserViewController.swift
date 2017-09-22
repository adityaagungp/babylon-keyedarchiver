//
//  EditUserViewController.swift
//  BabylonKeyArchiver
//
//  Created by Aditya Agung Putra on 9/22/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var suiteField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Edit User"
        initFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTextChanged(_ sender: UITextField) {
        btnSave.isEnabled = true
    }
    
    @IBAction func onSaveUser(_ sender: Any) {
        user?.email = emailField.text
        user?.website = websiteField.text
        user?.address?.street = streetField.text
        user?.address?.suite = suiteField.text
        user?.address?.city = cityField.text
        user?.address?.zipcode = zipcodeField.text
        
        //notify listener to save and reload local data
        let alert = UIAlertController(title: "Success", message: "User's changes saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.onSaveSuccess()})
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func initFields(){
        if let user = user {
            emailField.text = user.email
            websiteField.text = user.website
            streetField.text = user.address?.street
            suiteField.text = user.address?.suite
            cityField.text = user.address?.city
            zipcodeField.text = user.address?.zipcode
        }
    }
    
    private func onSaveSuccess(){
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UserChange"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}
