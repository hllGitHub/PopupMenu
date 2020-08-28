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

public class PopMenuView: UIView {
  static let cellId = "cellId"
  static let fillColor = UIColor(hexString: "#202B43")
  static let defaultAnimationDuration = 0.15

  weak var delegate: PopMenuViewDelegate?
  var font: UIFont = UIFont.systemFont(ofSize: 16)
  var direction: PopMenuDirection = .left
  var menus: [PopMenuItem] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  var origin: CGPoint = .zero
  var cellHeight: CGFloat = 44
  var separatorColor: UIColor = .black
  var textColor: UIColor = .white

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

  init(dataArray: [PopMenuItem], origin: CGPoint, size: CGSize, direction: PopMenuDirection) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    self.backgroundColor = UIColor(white: 0.3, alpha: 0.2)

    self.direction = direction
    self.origin = origin
    self.cellHeight = size.height

    let containerWidth = size.width
    let containerHeight = size.height * CGFloat(dataArray.count) + 20
    let anchorPoint = CGPoint(x: 1, y: 0)

    // 初始 `anchorPoint` 为 CGPoint(x: 0.5, y: 0.5)，调整锚点之后位置也需要调整
    let containerView = PopContainerView(frame: CGRect(x: origin.x + containerWidth * (anchorPoint.x - 0.5), y: origin.y + containerHeight * (anchorPoint.y - 0.5), width: containerWidth, height: containerHeight), fillColor: PopMenuView.fillColor)
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
    self.menus = dataArray
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
    UIView.animate(withDuration: PopMenuView.defaultAnimationDuration) {
      self.containerView?.transform = transform
      self.alpha = 1
    }
  }

  func dismiss() {
    self.alpha = 1
    UIView.animate(withDuration: PopMenuView.defaultAnimationDuration, animations: {
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
    return cellHeight
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PopMenuView.cellId, for: indexPath)

    guard indexPath.row < menus.count else {
      return cell
    }

    cell.setItem(menu: menus[indexPath.row])
    return cell
  }
}

public extension UITableViewCell {
  func setItem(menu: PopMenuItem) {
    imageView?.image = menu.icon
    imageView?.tintColor = .white
    textLabel?.text = menu.title
    textLabel?.font = UIFont.systemFont(ofSize: 16)
    textLabel?.textColor = .white
    backgroundColor = PopMenuView.fillColor
    selectionStyle = .none
  }
}

public struct PopMenuItem {
  var icon: UIImage?
  var title: String
}
