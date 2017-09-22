//
//  ViewController.swift
//  BabylonKeyArchiver
//
//  Created by Bukalapak on 9/15/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    fileprivate var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
        table.delegate = self
        let userNib = UINib(nibName: "UserViewCell", bundle: nil)
        table.register(userNib, forCellReuseIdentifier: "userCell")
        table.estimatedRowHeight = 90.0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(fetchUsers))
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDataChanged), name: Notification.Name(rawValue: "UserChange"), object: nil)
        getUsers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "UserChange"), object: nil)
    }
    
    private func getUsers(){
        users = getLocalUsers()
        table.reloadData()
        if users.isEmpty {
            fetchUsers()
        }
    }
    
    @objc private func fetchUsers(){
        Alamofire.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var result = [User]()
                for obj in json.arrayValue {
                    result.append(User.createFromJson(obj))
                }
                self.users = result
                self.saveEmployees()
                
            case .failure(let error):
                self.users = self.getLocalUsers()
                if self.users.isEmpty {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            self.table.reloadData()
        }
    }
    
    @objc private func onDataChanged(){
        saveEmployees()
        table.reloadData()
    }
    
    //obtain URL of the local file
    private func dataFileUrl() -> NSURL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("Users") as NSURL
    }
    
    //create local data
    fileprivate func saveEmployees() {
        let loadFile = dataFileUrl()
        NSKeyedArchiver.archiveRootObject(users, toFile: loadFile.path!)
    }
    
    //read local data
    private func getLocalUsers() -> [User]{
        let loadFile = dataFileUrl()
        if FileManager.default.fileExists(atPath: loadFile.path!) {
            if let loadedData = NSKeyedUnarchiver.unarchiveObject(withFile: loadFile.path!) as? [User] {
                return loadedData
            }
        }
        return [User]()
    }
    
    //delete local data
    private func deleteLocalUsers(){
        let loadFile = dataFileUrl()
        do {
            try FileManager.default.removeItem(at: loadFile as URL)
        } catch {
            
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserViewCell
        cell.user = users[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailVC = UserDetailViewController()
        userDetailVC.user = users[indexPath.row]
        navigationController?.pushViewController(userDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .fade)
            saveEmployees()
        }
    }
}
