//
//  ViewController.swift
//  KxProgressHUD
//
//  Created by 许亚光 on 2022/5/24.
//

import UIKit
import KxProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        KxProgressHUD.show()
        KxProgressHUD.show(withStatus: "")
        KxProgressHUD.showError(withStatus: "")
        KxProgressHUD.showSuccesswithStatus("")
        KxProgressHUD.showInfowithStatus("")
        
    }


}

