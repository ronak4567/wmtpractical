//
//  ViewController.swift
//  ronak
//
//  Created by Depixed on 16/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Variable Declaration
    @IBOutlet var txtUsername:UITextField!
    @IBOutlet var txtEmail:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var txtCPassword:UITextField!
    @IBOutlet var btnRegister:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnRegister.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Method
    func validateForm() -> String {
        let strUsername = txtUsername.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let strEmail = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let strPassword = txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let strCPassword = txtCPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        if strUsername.isEmpty  {
            return "Please enter username"
        }else if strEmail.isEmpty {
            return "Plsea enter email id."
        }else if !isValidEmail(strEmail) {
            return "Plsea enter valid email id."
        }else if strPassword.isEmpty {
            return "Plsea enter password."
        }else if strCPassword.isEmpty {
            return "Plsea enter confirm password."
        }else if strPassword != strCPassword{
            return "Confirm password does not match"
        }else {
            return ""
        }
    }
    
    //redirect to user list
    func redirectUserListPage() {
        var userlistVC:UserListViewController
        if #available(iOS 13.0, *) {
            userlistVC = self.storyboard?.instantiateViewController(identifier: "UserListViewController") as! UserListViewController
        } else {
            userlistVC = self.storyboard?.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        }
        
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: userlistVC);
    }
    
    //Check Valid Email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK:- Button Tapped Event
    @IBAction func tappedOnRegister(_ sender:UIButton){
        let strUsername = txtUsername.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let strEmail = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let strPassword = txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        
        let error = self.validateForm()
        if !error.isEmpty{
            let alert = UIAlertController (title: "Required", message: error, preferredStyle: .alert)
            let btnOK = UIAlertAction (title: "OK", style: .cancel, handler: nil)
            alert.addAction(btnOK)
            self.present(alert, animated: true, completion: nil)
        }else {
            
            let param = ["username": strUsername,
                         "email": strEmail,
                         "password": strPassword]
            appDelegate.showHud()
            NetworkManager.shared.registerUserAPI(param: param) { (user) in
                print(user)
                appDelegate.hideHud()
                let defaults = UserDefaults.standard
                if user.meta?.status == "ok"{
                    let token = user.data?.token?.token ?? ""
                    defaults.set(true, forKey: "isLogin")
                    defaults.set(token, forKey: "token")
                    self.redirectUserListPage()
                }else{
                    let message = user.meta?.message ?? ""
                    self.showAlert(msg: message)
                }
                
            }
        }
    }
    
    func showAlert(msg:String){
        let alert = UIAlertController(title: "Error Message", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            
        }))
        self.navigationController?.present(alert, animated: true, completion: {
            
        })
    }

    
    
}

