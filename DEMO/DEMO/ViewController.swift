//
//  ViewController.swift
//  DEMO
//
//  Created by 许亚光 on 2022/5/25.
//

import UIKit
import KxProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        KxProgressHUD.set(defaultStyle: .dark)
        KxProgressHUD.showSuccesswithStatus("hahahhhahahh")
    }

}

