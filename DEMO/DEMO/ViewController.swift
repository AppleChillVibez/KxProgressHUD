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
        
        let clayer = MyLayer()
        clayer.bounds = view.frame
        clayer.position = view.center
        clayer.gradientCenter = view.center
        view.layer.addSublayer(clayer)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        KxProgressHUD.set(defaultStyle: .dark)
//        KxProgressHUD.set(defaultMaskType: .gradient)
//        KxProgressHUD.showSuccesswithStatus("加载成功")
//        KxProgressHUD.dismissWithDelay(4)
        view.layer.sublayers?.first?.setNeedsDisplay()
    }

}


class MyLayer: CALayer {
    
    var gradientCenter = CGPoint.zero
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        let locationsCount: Int = 2
        let locations: [CGFloat] = [0.0, 1.0]
        let colors: [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locationsCount) {
            let radius = min(bounds.size.width, bounds.size.height)
            ctx.drawRadialGradient(gradient, startCenter: gradientCenter, startRadius: 0, endCenter: gradientCenter, endRadius: radius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
        
    }
    
}
