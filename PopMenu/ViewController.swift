//
//  ViewController.swift
//  PopMenu
//
//  Created by liangliang hu on 2020/8/27.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private lazy var menus = [
    PopMenuItem(icon: UIImage(named: "iconNfc"), title: "NFC"),
    PopMenuItem(icon: UIImage(named: "iconScanning"), title: "扫一扫")
  ]

  private lazy var rightMenuView: PopMenuView = {
    var configuration = PopMenuConfiguration()
    configuration.itemFont = .boldSystemFont(ofSize: 17)
    configuration.cornerRadius = 8
    configuration.itemHeight = 44
    configuration.animationDuration = 0.15
    configuration.itemTextColor = .orange

    let menuView = PopMenuView(dataArray: menus, origin: CGPoint(x: view.frame.width - 38, y: UIApplication.shared.statusHeight + 34), size: CGSize(width: 130, height: 44), direction: .right, configuration: configuration)
    menuView.delegate = self
    return menuView
  }()

  private lazy var leftMenuView: PopMenuView = {
    let menuView = PopMenuView(dataArray: menus, origin: CGPoint(x: 38, y: UIApplication.shared.statusHeight + 34), size: CGSize(width: 130, height: 44), direction: .left)
    menuView.delegate = self
    // 可以选择 callback 的方式
    menuView.clickCallback = {(_, index, item) in
      print("第 \(index) 个 item, \(item)")
    }
    return menuView
  }()

  @objc func openLeftMenu() {
    leftMenuView.show()
  }

  @objc func openRightMenu() {
    rightMenuView.show()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.title = "PopMenu Demo"
    setupNavigationBar()
  }

  private func setupNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false

    let leftAddButtonItem = UIBarButtonItem(image: UIImage(named: "iconAdd"), style: .plain, target: self, action: #selector(openLeftMenu))
    self.navigationItem.leftBarButtonItem = leftAddButtonItem

    let rightAddButtonItem = UIBarButtonItem(image: UIImage(named: "iconAdd"), style: .plain, target: self, action: #selector(openRightMenu))
    self.navigationItem.rightBarButtonItem = rightAddButtonItem
  }
}

extension ViewController: PopMenuViewDelegate {
  func popMenuView(_ popMenuView: PopMenuView, didSelectRowAt index: Int, item: PopMenuItem) {
    print("在 \(popMenuView) 中点击了第 \(index) 个菜单, \(item.title)")
  }
}

