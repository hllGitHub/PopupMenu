//
//  PopContainerView.swift
//  SproutBusiness
//
//  Created by liangliang hu on 2020/7/5.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class PopContainerView: UIView {
  var fillColor: UIColor {
    didSet {
      setNeedsLayout()
    }
  }

  var direction: PopMenuDirection {
    didSet {
      setNeedsLayout()
    }
  }

  init(frame: CGRect, fillColor: UIColor, direction: PopMenuDirection = .right) {
    self.fillColor = fillColor
    self.direction = direction
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draw(_ rect: CGRect) {
    let startX: CGFloat = rect.width + (direction == .left ? 25.0 : -25.0)
    let startY: CGFloat = 10.0

    let bezierPath = UIBezierPath()
    let squareRect = CGRect(x: 0, y: startY, width: rect.width, height: rect.height - startY)

    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: startX, y: startY))
    trianglePath.addLine(to: CGPoint(x: startX + 5, y: startY - 8))
    trianglePath.addLine(to: CGPoint(x: startX + 10, y: startY))
    trianglePath.close()

    let cornerRadius: CGFloat = 6

    let squarePath = UIBezierPath(roundedRect: squareRect, cornerRadius: cornerRadius)

    bezierPath.append(squarePath)
    bezierPath.append(trianglePath)

    fillColor.setFill()
    bezierPath.fill()
  }
}
