//
//  ViewController.swift
//  AnimotorDEMO
//
//  Created by 许亚光 on 2022/6/2.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var animator: KxTransitionAnimator = {
        let a = KxTransitionAnimator()
        return a
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
  
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = KxViewController()
        vc.transitioningDelegate = animator
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        present(vc, animated: true)
    }

}

