//
//  AnimationDrawer.swift
//  Receiver
//
//  Created by Enkhjargal Gansukh on 02/11/2017.
//  Copyright © 2017 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import UIKit

class AnimationDrawer: UIView {
    
    let bgColor = UIColor(red: 252.0/255, green: 95.0/255, blue: 86.0/255, alpha: 1.0)
    
    let switchCircle = CAShapeLayer()
    let switchField = CAShapeLayer()
    let ironLayer = CAShapeLayer()
    let lockBody = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = bgColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLockerIron()
        drawLockBody()
        drawSwitchField()
        drawKeyCircle()
    }
    
    func lock(){
        animateSwitch2()
    }
    
    func unlock(){
        animateSwitch1()
    }
    
    func drawLockBody(){
        let rectWidth:CGFloat = 160
        let rectHeight:CGFloat = 140
        
        let xf:CGFloat = (self.frame.width  - rectWidth)  / 2
        let yf:CGFloat = (self.frame.height - rectHeight) / 2
        
        let rect = CGRect(x: xf, y: yf, width: rectWidth, height: rectHeight)
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        lockBody.lineWidth = 3
        lockBody.path = clipPath.cgPath
        lockBody.strokeColor = UIColor.white.cgColor
        lockBody.fillColor = bgColor.cgColor
        self.layer.addSublayer(lockBody)
    }
    
    func drawSwitchField(){
        let rect = CGRect(x: (self.frame.width - 40) / 2, y: (self.frame.height - 18) / 2, width: 40, height: 18)
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        
        switchField.lineWidth = 3
        switchField.path = clipPath.cgPath
        switchField.strokeColor = UIColor.white.cgColor
        switchField.fillColor = bgColor.cgColor
        self.layer.addSublayer(switchField)
    }
    func drawKeyCircle(){
        let rect = CGRect(x: (self.frame.width - 50) / 2, y: (self.frame.height - 25) / 2, width: 25, height: 25)
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 15)
        switchCircle.lineWidth = 3
        switchCircle.path = clipPath.cgPath
        switchCircle.strokeColor = UIColor.white.cgColor
        switchCircle.fillColor = bgColor.cgColor
        self.layer.addSublayer(switchCircle)
    }
    
    func drawLockerIron(){
        let startAngle = 0.1
        let endAngle = -0.1 - Double.pi
        let arcCenter = CGPoint.init(x: self.frame.width/2, y: self.frame.width/3 - 10)
        let clipPath = UIBezierPath(arcCenter: arcCenter, radius: 40, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: false)
        clipPath.addArc(withCenter: arcCenter, radius: 60, startAngle: CGFloat(endAngle), endAngle: CGFloat(startAngle), clockwise: true)
        ironLayer.path = clipPath.cgPath
        ironLayer.bounds = clipPath.cgPath.boundingBox
        ironLayer.lineWidth = 3
        ironLayer.strokeColor = UIColor.white.cgColor
        ironLayer.fillColor = bgColor.cgColor
        ironLayer.position = CGPoint(x: self.layer.bounds.width/2, y: self.layer.bounds.height/3 - 30)
        self.layer.addSublayer(ironLayer)
    }
    
    
    func animateSwitch1(){
        switchCircle.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        let oldBounds = switchCircle.bounds
        var newBounds = oldBounds
        newBounds.origin.x = -30.0
        
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.toValue = NSValue(cgRect: newBounds)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        switchCircle.add(animation, forKey: "switchLock1")
        switchCircle.fillColor = UIColor.white.cgColor
        animateIron1()
    }
    func animateSwitch2(){
        switchCircle.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        let oldBounds = switchCircle.bounds
        var newBounds = oldBounds
        newBounds.origin.x = -30.0
        
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.toValue = NSValue(cgRect: oldBounds)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        switchCircle.add(animation, forKey: "switchLock2")
        switchCircle.fillColor = bgColor.cgColor
        animateIron2()
    }
    
    func animateIron1(){
        ironLayer.position = CGPoint(x: self.layer.bounds.width/2 + 60, y: self.layer.bounds.height/3)
        ironLayer.anchorPoint = CGPoint(x: 1.0, y: 0.9)
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = CGFloat(Double.pi / 8)
        rotateAnimation.duration = 0.3
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.isRemovedOnCompletion = false
        ironLayer.add(rotateAnimation, forKey: "rotateIron1")
    }
    
    func animateIron2(){
        ironLayer.position = CGPoint(x: self.layer.bounds.width/2 + 60, y: self.layer.bounds.height/3)
        ironLayer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = CGFloat(Double.pi / 8)
        rotateAnimation.toValue = 0
        rotateAnimation.duration = 0.2
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.isRemovedOnCompletion = false
        ironLayer.add(rotateAnimation, forKey: "rotateIron1")
    }
}
