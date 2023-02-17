//
//  CGPoint.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 17/02/2023.
//

import Foundation

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func random(in rect: CGRect, radius: CGFloat = 0) -> CGPoint {
        let x = CGFloat.random(in: (rect.origin.x + radius)...(rect.origin.x + rect.size.width - radius))
         let y = CGFloat.random(in: (rect.origin.y + radius)...(rect.origin.y + rect.size.height - radius))
         return CGPoint(x: x, y: y)
    }
}
