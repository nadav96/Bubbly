//
//  CircleView.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class CircleView: UIView {
    var radius: CGFloat = 0.0
    var colorIndex: Int = 0
    let COLORS: [UIColor] = [UIColor.red, UIColor.yellow, UIColor.purple, UIColor.black]
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.radius = CGFloat(arc4random_uniform(10)*10+10)
        self.colorIndex = Int(arc4random_uniform(4))
        self.frame.size = CGSize(width: self.radius, height: self.radius)
        
        print(self.colorIndex, self.radius)
        self.backgroundColor = .red
        
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        
        self.setupCircle()
    }
    
    private func setupCircle() {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        
        layer.addSublayer(shapeLayer)
    }
}
