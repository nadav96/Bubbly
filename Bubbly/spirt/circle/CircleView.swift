//
//  CircleView.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class CircleView: UIView {
    var directionVector: Vector = .zero
    
    var radius: CGFloat = 0.0
    var colorIndex: Int = 0
    var color: UIColor = .red
    let COLORS: [UIColor] = [UIColor.red, UIColor.yellow, UIColor.purple]
    
    var v: UIView!
    
    // MARK: -
    convenience init(radius: CGFloat?, startVector: Vector, startOrigin: CGPoint, color: UIColor? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.directionVector = startVector
        
        // MARK: initial design
        
        // add color
        self.colorIndex = Int(arc4random_uniform(UInt32(self.COLORS.count)))
        self.color = color != nil ? color! : COLORS[self.colorIndex]
        
        self.radius = radius != nil ? radius! : CGFloat(arc4random_uniform(10)*3+50)
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = false
        
        // MARK: initial location
        self.frame.size = CGSize(width: self.radius*2, height: self.radius*2)
        self.frame.origin = startOrigin
        
        self.setupCircle()
        
        self.v = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        v.backgroundColor = .black
        self.v.layer.cornerRadius = 5
        self.addSubview(v)
    }
    
    
    override func layoutSubviews() {
        self.v.frame.origin = CGPoint(x: self.frame.width/2 - 5, y: self.frame.height/2 - 5)
        
        drawArrow(from: self.v.frame.origin + CGPoint(x: 5, y: 5), angle: self.directionVector.angle, velocity: self.directionVector.length)
    }
    
    private func polar(alpha: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        let x = cos(alpha) * radius
        let y = -sin(alpha) * radius
        return CGPoint(x: x, y: y) + offset
    }
    
    private func setupCircle() {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = self.color.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        
        layer.addSublayer(shapeLayer)
    }
    
    func render() {
        let distancePerFrame = self.directionVector.length / 60
        
        var origin = self.frame.origin
        let dx = distancePerFrame * cos(self.directionVector.angle)
        let dy = -distancePerFrame * sin(self.directionVector.angle)
        
        origin.x += dx
        origin.y += dy
        self.frame.origin = origin
    }

    func drawArrow(from: CGPoint, angle: CGFloat, velocity: CGFloat) {
        let endPoint = endPoint(from: from, angle: angle, length: self.radius + velocity)
        
        drawLine(from: from, to: endPoint, color: .black, width: 2)
    }

    func endPoint(from startPoint: CGPoint, angle: CGFloat, length: CGFloat) -> CGPoint {
        let dx = length * cos(angle)
        let dy = -length * sin(angle)
        return CGPoint(x: startPoint.x + dx, y: startPoint.y + dy)
    }
    
    private func drawLine(from startPoint: CGPoint, to endPoint: CGPoint, color: UIColor, width: CGFloat) {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width

        // Add the shape layer to your view's layer
//        self.layer.insertSublayer(shapeLayer, at: 0)
        self.layer.addSublayer(shapeLayer)
        
    }


}
