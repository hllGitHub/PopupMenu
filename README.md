# JHPopMenu
仿微信右上角弹出菜单

* 使用 Swift
* iOS 11.0, Swift 4.0+

## Using CocoaPods
``` ruby
pod 'JHPopMenu'
```

## Usage

``` swift
private lazy var menus = [
  PopMenuItem(icon: UIImage(named: "iconNfc"), title: "Nfc"),
  PopMenuItem(icon: UIImage(named: "iconScanning"), title: "扫一扫")
]

private lazy var menuView: PopMenuView = {
  let menuView = PopMenuView(dataArray: menus, origin: CGPoint(x: view.frame.width - 152, y: 80), size: CGSize(width: 130, height: 44), direction: .left)
  menuView.delegate = self
  return menuView
}()

menuView.show()

```

