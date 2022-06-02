//
//  PresentAnimator.swift
//  AnimotorDEMO
//
//  Created by 许亚光 on 2022/6/2.
//

import Foundation
import UIKit

public typealias KxNavigationOperation = UINavigationController.Operation

public enum KxTabBarOperationDirection {
    case left
    case right
}

public enum KxModalOperation {
    case present
    case dismiss
}

public enum KxTransitionType {
    case navigation(_ operation: KxNavigationOperation)
    case tabBar(_ direction: KxTabBarOperationDirection)
    case modal(_ operation: KxModalOperation)
}

open class KxTransitionAnimator: NSObject {
    lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    /// 转场类型
    var transitionType: KxTransitionType?
    /// 交互转场
    var interactive = false
    let interactionTransition = UIPercentDrivenInteractiveTransition()
    override init() {
        super.init()
    }
}

/// 转场动画代理
extension KxTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from_vc = transitionContext.viewController(forKey: .from),
                  let from_view = from_vc.view,
                  let to_vc = transitionContext.viewController(forKey: .to),
                  let to_view = to_vc.view else {
                      return
                  }
        
        let containerView = transitionContext.containerView
        containerView.backgroundColor = .clear
        let duration = self.transitionDuration(using: transitionContext)
        
        var offset = containerView.frame.width
        var fromTransform = CGAffineTransform.identity
        var toTransform = CGAffineTransform.identity
        var fromAlpha = 0.0
        var toAlpha = 0.0
        
        switch transitionType {
        case .navigation(let operation):
            print("\(operation)")
            offset = operation == .push ? offset : -offset
            fromTransform = CGAffineTransform(translationX: -offset, y: 0)
            toTransform = CGAffineTransform(translationX: offset, y: 0)
            containerView.insertSubview(to_view, at: 0)
            
        case .tabBar(let direction):
            print("\(direction)")
            offset = direction == .left ? offset : -offset
            fromTransform = CGAffineTransform(translationX: offset, y: 0)
            toTransform = CGAffineTransform(translationX: -offset, y: 0)
            containerView.addSubview(to_view)
            
        case .modal(let operation):
            print("\(operation)")
            offset = containerView.frame.height
            fromAlpha = operation == .present ? 0 : 1
            toAlpha = operation == .present ? 1 : 0
            let fromY = operation == .present ? 0 : offset
            fromTransform = CGAffineTransform(translationX: 0, y: fromY)
            let toY = operation == .present ? offset : 0
            toTransform = CGAffineTransform(translationX: 0, y: toY)
            if operation == .present {
                containerView.addSubview(to_view)
            }
                        
        case .none:
            break
        }
        
        self.coverView.alpha = fromAlpha
        self.coverView.frame = containerView.bounds
        containerView.insertSubview(self.coverView, at: 0)
        
        to_view.transform = toTransform
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            to_view.transform = .identity
            from_view.transform = fromTransform
            self.coverView.alpha = toAlpha
        } completion: { finished in
            from_view.transform = .identity
            to_view.transform = .identity
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}

/// 自定义navigation转场动画时使用
extension KxTransitionAnimator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .navigation(operation)
        return self
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionTransition : nil
    }
}

/// 自定义tab转场动画时使用
extension KxTransitionAnimator: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fromIndex = tabBarController.viewControllers?.firstIndex(of: fromVC) ?? 0
        let toIndex = tabBarController.viewControllers?.firstIndex(of: toVC) ?? 0
        let direction: KxTabBarOperationDirection = fromIndex < toIndex ? .right : .left
        self.transitionType = .tabBar(direction)
        return self
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionTransition : nil
    }
}

/// 自定义Modal转场动画时使用
extension KxTransitionAnimator: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .modal(.present)
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .modal(.dismiss)
        return self
    }
    
    /// interactive false:非交互转场， true: 交互转场
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionTransition : nil
    }
    
    /// interactive false:非交互转场， true: 交互转场
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionTransition : nil
    }
}
