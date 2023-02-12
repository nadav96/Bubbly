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
    
    var v: UIView!
    var v2: UIView!
    
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.radius = 50//CGFloat(arc4random_uniform(10)*10+10)
        self.colorIndex = Int(arc4random_uniform(4))
        self.frame.size = CGSize(width: self.radius*2, height: self.radius*2)
        
        print(self.colorIndex, self.radius)
        self.backgroundColor = .red
        
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = false
        
        self.setupCircle()
//        self.setupArrow()
        
        self.v = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        v.backgroundColor = .black
        self.addSubview(v)
        
        self.v2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        v2.backgroundColor = .black
        self.addSubview(v2)
        
        
        print("SA: \(self.center)")
    }
    
    override func layoutSubviews() {
        self.v.frame.origin = CGPoint(x: self.frame.width/2 - 5, y: self.frame.height/2 - 5)
        
        let a = calculateArrowStartingPoint(alpha: .pi/2)
        print(a)
        self.v2.frame.origin = calculateArrowStartingPoint(alpha: .pi/4) + self.v.center + CGPoint(x: -5, y: -5)
    }
    
    private func calculateArrowStartingPoint(alpha: CGFloat) -> CGPoint {
        let x = cos(alpha) * self.radius
        let y = -sin(alpha) * self.radius
        return CGPoint(x: x, y: y)
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
        let arrow = UIBezierPath()
        let startTouchPoint = CGPoint(x: self.frame.origin.x + 30, y: self.frame.origin.y + 30) //CGPoint(x: 200, y: 200)
        let secondTouchPoint = CGPoint(x: self.frame.origin.x + 100, y: self.frame.origin.x + 100)  //CGPoint(x: 50, y: 50)
        arrow.addArrow(start: startTouchPoint, end: secondTouchPoint, pointerLineLength: 20, arrowAngle: CGFloat(Double.pi / 5))

        let arrowLayer = CAShapeLayer()
        let path = CGMutablePath()
        arrowLayer.strokeColor = UIColor.black.cgColor
//        arrowLayer.lineDashPattern = [7, 6]
        arrowLayer.lineWidth = 2
        path.addPath(arrow.cgPath)
        path.addLines(between: [startTouchPoint, secondTouchPoint])
        arrowLayer.path = path

        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.lineJoin = CAShapeLayerLineJoin.round
        arrowLayer.lineCap = CAShapeLayerLineCap.round

        self.layer.addSublayer(arrowLayer)
    }

}

extension UIBezierPath {
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        self.move(to: start)
        self.addLine(to: end)

        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))

        self.addLine(to: arrowLine1)
        self.move(to: end)
        self.addLine(to: arrowLine2)
    }
}

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
