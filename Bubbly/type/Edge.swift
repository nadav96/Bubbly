//
//  Edge.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 17/02/2023.
//

import Foundation

enum Edge {
    case top(p: CGPoint)
    case bottom(p: CGPoint)
    case left(p: CGPoint)
    case right(p: CGPoint)
    
    func normal() -> Vector {
        switch self {
        case .bottom:
            return Vector(angle: .pi/2, length: 1)
        case .left:
            return Vector(angle: 0, length: 1)
        case .right:
            return Vector(angle: .pi, length: 1)
        case .top:
            return Vector(angle: 3 * .pi / 2, length: 1)
        }
    }
}
