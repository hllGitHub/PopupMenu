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
    PopMenuItem(icon: UIImage(named: "iconNfc"), title: "Nfc"),
    PopMenuItem(icon: UIImage(named: "iconScanning"), title: "扫一扫")
  ]

  private lazy var menuView: PopMenuView = {
    let menuView = PopMenuView(dataArray: menus, origin: CGPoint(x: view.frame.width - 152, y: 80), size: CGSize(width: 130, height: 44), direction: .left)
    menuView.delegate = self
    return menuView
  }()

  @objc func openMenu() {
    menuView.show()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigationBar()
  }

  private func setupNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#B620E0")
    self.navigationController?.navigationBar.tintColor = UIColor.white

    let addButtonItem = UIBarButtonItem(image: UIImage(named: "iconAdd"), style: .plain, target: self, action: #selector(openMenu))
    self.navigationItem.rightBarButtonItem = addButtonItem
  }
}

extension ViewController: PopMenuViewDelegate {
  func popMenuView(_ popMenuView: PopMenuView, didSelectRowAt index: Int, item: PopMenuItem) {
    print("点击了第 \(index) 个菜单, \(item.title)")
  }
}

