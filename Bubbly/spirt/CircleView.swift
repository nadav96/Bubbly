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
        self.setupArrow()
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
    
    private func setupArrow() {
          // Generate random arrow width and direction
          let arrowWidth = CGFloat.random(in: 10...bounds.width/2)
          let arrowDirection = CGFloat.random(in: 0...360)
          
          let arrowPath = UIBezierPath()
          arrowPath.move(to: CGPoint(x: bounds.width/2, y: bounds.height/2))
          arrowPath.addLine(to: CGPoint(x: bounds.width/2 + arrowWidth, y: bounds.height/2))
          arrowPath.addLine(to: CGPoint(x: bounds.width/2 + arrowWidth/2, y: bounds.height/2 - arrowWidth/2))
          arrowPath.addLine(to: CGPoint(x: bounds.width/2 + arrowWidth/2, y: bounds.height/2 + arrowWidth/2))
          arrowPath.addLine(to: CGPoint(x: bounds.width/2 + arrowWidth, y: bounds.height/2))
          
          let arrowLayer = CAShapeLayer()
          arrowLayer.path = arrowPath.cgPath
          arrowLayer.fillColor = UIColor.clear.cgColor
          arrowLayer.strokeColor = UIColor.black.cgColor
          arrowLayer.lineWidth = 2.0
          arrowLayer.lineCap = .round
          arrowLayer.lineJoin = .round
          
          // Rotate the arrow layer to point in the random direction
          arrowLayer.transform = CATransform3DMakeRotation(arrowDirection * CGFloat.pi / 180, 0, 0, 1)
          
          layer.addSublayer(arrowLayer)
      }
}
