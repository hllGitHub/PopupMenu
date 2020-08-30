//
//  PopMenuView.swift
//  SproutBusiness
//
//  Created by liangliang hu on 2020/7/4.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public protocol PopMenuViewDelegate: NSObjectProtocol {
  func popMenuView(_ popMenuView: PopMenuView, didSelectRowAt index: Int, item: PopMenuItem)
}

public enum PopMenuDirection {
  case left
  case right
}

public struct PopMenuConfiguration {
  var arrowSize: CGFloat = 20           // 箭头大小
  var arrowMargin: CGFloat = 10         // 箭头和目标视图的距离

  var animationDuration: Double = 0.15  // 动画时长
  var cornerRadius: CGFloat = 6         // 菜单的圆角
  var separatorColor: UIColor = .black  // 分割线颜色
  var fillColor: UIColor = UIColor(hexString: "#202B43")       // 菜单的背景填充色

  var itemFont: UIFont = UIFont.systemFont(ofSize: 16)         // 菜单项的字体
  var itemHeight: CGFloat = 44          // 菜单项的高度
  var itemTextColor: UIColor = .white   // 菜单项文本颜色
}

public class PopMenuView: UIView {
  static let cellId = "cellId"
  static let defaultAnimationDuration = 0.15

  var origin: CGPoint = .zero
  var configuration: PopMenuConfiguration = PopMenuConfiguration()
  weak var delegate: PopMenuViewDelegate?

  var direction: PopMenuDirection = .left
  var menus: [PopMenuItem] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.backgroundColor = .clear
    tableView.bounces = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: PopMenuView.cellId)
    tableView.tableFooterView = UIView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  var containerView: PopContainerView?
  var menuContainerTransform: CGAffineTransform?

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(dataArray: [PopMenuItem], origin: CGPoint, size: CGSize, direction: PopMenuDirection, configuration: PopMenuConfiguration = PopMenuConfiguration()) {
    self.configuration = configuration
    self.direction = direction
    self.origin = origin
    self.menus = dataArray

    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    self.backgroundColor = UIColor(white: 0.3, alpha: 0.2)

    _setup(dataArray: dataArray, origin: origin, size: size, direction: direction)
  }

  private func _setup(dataArray: [PopMenuItem], origin: CGPoint, size: CGSize, direction: PopMenuDirection) {
    let containerWidth = size.width
    let containerHeight = size.height * CGFloat(dataArray.count) + configuration.arrowSize
    let anchorPoint = direction == .left ? CGPoint(x: 0, y: 0) : CGPoint(x: 1, y: 0)

    let offset = direction == .left ? -20 : -(containerWidth - 20)
    let originX = origin.x + offset
    let originY = origin.y

    // 初始 `anchorPoint` 为 CGPoint(x: 0.5, y: 0.5)，调整锚点之后位置也需要调整
    let containerView = PopContainerView(frame: CGRect(x: originX + containerWidth * (anchorPoint.x - 0.5), y: originY + containerHeight * (anchorPoint.y - 0.5), width: containerWidth, height: containerHeight), fillColor: configuration.fillColor, cornerRadius: configuration.cornerRadius, direction: direction)
    containerView.backgroundColor = .clear
    addSubview(containerView)
    containerView.addSubview(tableView)
    menuContainerTransform = containerView.transform
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
      tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
      tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
    ])

    self.containerView = containerView
    self.containerView?.layer.anchorPoint = anchorPoint
  }

  override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    dismiss()
  }
}

protocol PopManager {
  func show()
  func dismiss()
}

extension PopMenuView: PopManager {
  func show() {
    let window = UIApplication.shared.window
    window?.addSubview(self)
    let transform = menuContainerTransform ?? self.tableView.transform

    self.alpha = 0
    UIView.animate(withDuration: configuration.animationDuration) {
      self.containerView?.transform = transform
      self.alpha = 1
    }
  }

  func dismiss() {
    self.alpha = 1
    UIView.animate(withDuration: configuration.animationDuration, animations: {
      self.containerView?.transform = CGAffineTransform(scaleX: 0, y: 0)
      self.alpha = 0
    }, completion: { _ in
      self.removeFromSuperview()
    })
  }
}

extension PopMenuView: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.delegate?.popMenuView(self, didSelectRowAt: indexPath.row, item: menus[indexPath.row])
    dismiss()
  }
}

extension PopMenuView: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menus.count
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return configuration.itemHeight
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PopMenuView.cellId, for: indexPath)

    guard indexPath.row < menus.count else {
      return cell
    }

    cell.setItem(menu: menus[indexPath.row])
    cell.textLabel?.font = configuration.itemFont
    cell.textLabel?.textColor = configuration.itemTextColor
    cell.backgroundColor = configuration.fillColor
    return cell
  }
}

public extension UITableViewCell {
  func setItem(menu: PopMenuItem) {
    imageView?.image = menu.icon
    imageView?.tintColor = .white
    textLabel?.text = menu.title
    selectionStyle = .none
  }
}

public struct PopMenuItem {
  var icon: UIImage?
  var title: String
}
