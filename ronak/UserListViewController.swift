//
//  UserListViewController.swift
//  ronak
//
//  Created by hariprabodham on 16/04/21.
//

import UIKit
import SDWebImage
class CustomCell: UITableViewCell {
    @IBOutlet var imgProfilePic:UIImageView!
    @IBOutlet var lblUserName:UILabel!
    @IBOutlet var lblEmail:UILabel!
}

class UserListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tblView:UITableView!
    var arrRecord:[Any] = []
    var currentPage:Int = 1
    var lastPage:Int = 0
    var strToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User List"
        tblView.tableFooterView = UIView()
        
        let defaults = UserDefaults.standard
        strToken = defaults.string(forKey: "token") ?? ""
        appDelegate.showHud()
        NetworkManager.shared.getUserList(page: currentPage, strToken: strToken) { (userList) in
            appDelegate.hideHud()
            print(userList)
            let dictData = userList["data"] as! Dictionary<String,Any>
            let dictMeta = userList["meta"] as! Dictionary<String,Any>
            if let status = dictMeta["status"] as? String, status == "ok"{
                self.arrRecord = dictData["users"] as! [Any]
                let dictPagination = dictData["pagination"] as! Dictionary<String,Any>
                if let _totalUser = dictPagination["lastPage"] as? Int{
                    self.lastPage = _totalUser
                }
                
            }
            self.tblView.reloadData()
            
        }

        // Do any additional setup after loading the view.
    }
    
    func loadMoreUser() {
        currentPage = currentPage + 1
        appDelegate.showHud()
        NetworkManager.shared.getUserList(page: currentPage, strToken: strToken) { (userList) in
            print(userList)
            appDelegate.hideHud()
            let dictData = userList["data"] as! Dictionary<String,Any>
            let dictMeta = userList["meta"] as! Dictionary<String,Any>
            if let status = dictMeta["status"] as? String, status == "ok"{
                let userList = dictData["users"] as! [Any]
                self.arrRecord.append(contentsOf: userList)
            }
            self.tblView.reloadData()
            
        }
    }
    
    
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let dictDetail = self.arrRecord[indexPath.row] as! Dictionary<String,Any>
        cell.lblUserName.text = "UserName:- \(dictDetail["username"] as? String ?? "")"
        cell.lblEmail.text = "Email:- \(dictDetail["email"] as? String ?? "")"
        if let strUrl = dictDetail["profile_pic"] as? String{
            cell.imgProfilePic.sd_setImage(with: URL(string: strUrl), completed: nil)
        }
        if indexPath.row == arrRecord.count - 1 {
            if self.lastPage > currentPage {
                loadMoreUser()
            }
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
