//
//  AppDelegate.swift
//  ronak
//
//  Created by Depixed on 16/04/21.
//

import UIKit
import IQKeyboardManagerSwift

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var mbProgressHud:MBProgressHUD!
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
//        if #available(iOS 13, *) {
//            // do only pure app launch stuff, not interface stuff
//        } else {
//            self.window = UIWindow()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.window!.rootViewController = UINavigationController(rootViewController: viewController)
//            self.window!.makeKeyAndVisible()
//            self.window!.backgroundColor = .red
//        }
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "isLogin") {
            var userlistVC:UserListViewController
            if #available(iOS 13.0, *) {
                userlistVC = storyBoard.instantiateViewController(identifier: "UserListViewController") as! UserListViewController
            } else {
                userlistVC = storyBoard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
            }
            
            window?.rootViewController = UINavigationController(rootViewController: userlistVC);
        }
        
        return true
        
        
        
    }
    
    
    
    //MARK: - HUD method
    func showHud()  {
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            self.mbProgressHud = MBProgressHUD.showAdded(to: window, animated: true)
            self.mbProgressHud.label.text = "Please wait..."
        }
    }
    
    func hideHud() {
        if self.mbProgressHud != nil {
            self.mbProgressHud.hide(animated: true)
        }
    }
    
    
}

