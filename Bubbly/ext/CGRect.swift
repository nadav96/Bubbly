//
//  CGRect.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 17/02/2023.
//

import Foundation

extension CGRect {
    func decreaseEqually(by: CGFloat) -> CGRect {
        var newRect = self
        newRect.origin = CGPoint(x: by, y: by)
        newRect.size = CGSize(width: self.size.width - 2 * by, height: self.size.height - 2 * by)
        return newRect
    }
}
