
//
//  U_MyDataTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyDataTableViewController: UITableViewController {

    @IBOutlet weak var UserImageImgVIew: UIImageView!
    @IBOutlet weak var UserPhoneLabel: UILabel!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    var Username: String! = ""
    let loginmodel = LoginModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Messages().showNow(code: 0x2004)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyData(_:)), name: NSNotification.Name(rawValue: "MyData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyDataImage(_:)), name: NSNotification.Name(rawValue: "MyDataImage"), object: nil)
        UserReposity().MyData(Requesting: Model_MyData.Requesting(UserName: Username))
    }
    
    @IBAction func U_back(segue:UIStoryboardSegue) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 0
        default:
            return 3
        }
    }
    
    func MyData(_ notification:Notification) {
        if let Response: Model_MyData.Response = notification.object as? Model_MyData.Response{
            ProgressHUD.dismiss()
            if let userpic = Response.UserPic
            {
                let Requesting = Model_ImageData.Requesting(DataUrl: userpic, DataName: .UserImage)
                UserReposity().download(Requesting: Requesting)
                Messages().showNow(code: 0x1014)
            }
            else{
                let imagename = "UserImage.png"
                let imagePath = UploadImage().fileInDocumentsDirectory(filename: imagename)
                let _ = UploadImage().saveImage(image: UIImage(named: "默认头像")!, path: imagePath)
                
            }
            UserPhoneLabel.text = Response.PhoneNum                       
            CompanyNameLabel.text = Response.Unit
            tableView.reloadData()
        }
        else {
            Messages().showError(code: 0x2004)
        }
    }
    func MyDataImage(_ notification:Notification) {
        if let Response: Model_ImageData.Response = notification.object as? Model_ImageData.Response{
            if let loadedImage = UploadImage().loadImageFromPath(path: Response.FileUrl)
            {
                UserImageImgVIew.image = loadedImage
                ProgressHUD.dismiss()
            }
            else{
                Messages().showError(code: 0x1002)
            }
        }
        else {
            Messages().showError(code: 0x1013)
        }
    }

}
