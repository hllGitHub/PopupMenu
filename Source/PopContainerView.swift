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

  var cornerRadius: CGFloat {
    didSet {
      setNeedsLayout()
    }
  }

  var direction: PopMenuDirection {
    didSet {
      setNeedsLayout()
    }
  }

  var arrowSize: CGFloat {
    didSet {
      setNeedsLayout()
    }
  }

  var arrowOffset: CGFloat {
    didSet {
      setNeedsLayout()
    }
  }

  init(frame: CGRect, fillColor: UIColor, cornerRadius: CGFloat, direction: PopMenuDirection = .right, arrowSize: CGFloat, arrowOffset: CGFloat) {
    self.fillColor = fillColor
    self.cornerRadius = cornerRadius
    self.direction = direction
    self.arrowSize = arrowSize
    self.arrowOffset = arrowOffset
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draw(_ rect: CGRect) {
    let startX: CGFloat = (direction == .left ? (arrowOffset - arrowSize * 0.5) : rect.width - (arrowOffset + arrowSize * 0.5))
    let startY: CGFloat = arrowSize

    let bezierPath = UIBezierPath()
    let squareRect = CGRect(x: 0, y: startY, width: rect.width, height: rect.height - startY)

    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: startX, y: startY))
    trianglePath.addLine(to: CGPoint(x: startX + arrowSize * 0.5, y: startY - (arrowSize - 2)))
    trianglePath.addLine(to: CGPoint(x: startX + arrowSize, y: startY))
    trianglePath.close()

    let cornerRadius: CGFloat = self.cornerRadius

    let squarePath = UIBezierPath(roundedRect: squareRect, cornerRadius: cornerRadius)

    bezierPath.append(squarePath)
    bezierPath.append(trianglePath)

    fillColor.setFill()
    bezierPath.fill()
  }
}
