//
//  KxViewController.swift
//  AnimotorDEMO
//
//  Created by 许亚光 on 2022/6/2.
//

import UIKit

class KxViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //滑动手势
    private var panGesture = UIPanGestureRecognizer()
    //转场动画
    private let animator = KxTransitionAnimator()
    
    private var transitionDelegate: KxTransitionAnimator {
        return self.transitioningDelegate as! KxTransitionAnimator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let btn = UIButton()
        btn.setTitle("dismiss", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(dismissClicked(_:)), for: .touchUpInside)
        btn.center = self.view.center
        btn.bounds = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.view.addSubview(btn)
        
        let screenEdgePan = UIScreenEdgePanGestureRecognizer()
        screenEdgePan.edges = .left
        screenEdgePan.addTarget(self, action: #selector(screenEdgePanHandle(_:)))
        self.view.addGestureRecognizer(screenEdgePan)
        
        /// 添加交互手势
//        panGesture.addTarget(self, action: #selector(verticalPanHandle(_:)))
//        self.view.addGestureRecognizer(panGesture)
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    
    @objc func verticalPanHandle(_ pan: UIPanGestureRecognizer) {
        let translationY = pan.translation(in: view).y
        let absY = abs(translationY)
        let progress = absY / view.frame.height
        
        switch pan.state {
        case .began:
            transitionDelegate.interactive = true
            //如果转场代理提供了交互控制器，它将从这时候开始接管转场过程。
            self.dismiss(animated: true, completion: nil)
            
        case .changed:
            transitionDelegate.interactionTransition.update(progress)
            
        case .cancelled, .ended:
            if progress > 0.5 {
                transitionDelegate.interactionTransition.completionSpeed = 0.99
                transitionDelegate.interactionTransition.finish()
            }else {
                transitionDelegate.interactionTransition.completionSpeed = 0.99
                transitionDelegate.interactionTransition.cancel()
            }
            transitionDelegate.interactive = false
            
        default:
            break
        }
    }
    
    ///边缘滑动dismiss
    @objc func screenEdgePanHandle(_ pan: UIScreenEdgePanGestureRecognizer) {
        let translationX = pan.translation(in: view).x
        let absX = abs(translationX)
        let progress = absX / view.frame.width
        
        switch pan.state {
        case .began:
            transitionDelegate.interactive = true
            self.dismiss(animated: true, completion: nil)
            
        case .changed:
            transitionDelegate.interactionTransition.update(progress)
            
        case .cancelled, .ended:
            if progress > 0.5 {
                transitionDelegate.interactionTransition.finish()
            }else {
                transitionDelegate.interactionTransition.cancel()
            }
            transitionDelegate.interactive = false
            
        default:
            transitionDelegate.interactive = false
        }
    }
    
    @objc func dismissClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
