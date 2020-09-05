# JHPopMenu
仿微信右上角弹出菜单

* 使用 Swift
* iOS 10.0, Swift 4.0+

## Using CocoaPods
``` ruby
pod 'JHPopMenu', '~> 0.0.2beta'
```

## Usage

``` swift
// 初始化数据项
private lazy var menus = [
  PopMenuItem(icon: UIImage(named: "iconNfc"), title: "Nfc"),
  PopMenuItem(icon: UIImage(named: "iconScanning"), title: "扫一扫")
]

// 方式1
private lazy var menuView: PopMenuView = {
  let menuView = PopMenuView(dataArray: menus, origin: CGPoint(x: view.frame.width - 152, y: 80), size: CGSize(width: 130, height: 44), direction: .left)
  menuView.delegate = self
  return menuView
}()

// 方式2
private lazy var menuView: PopMenuView = {
  var configuration = PopMenuConfiguration()
  configuration.itemFont = .boldSystemFont(ofSize: 17)
  configuration.cornerRadius = 8
  configuration.itemHeight = 44
  configuration.animationDuration = 0.15
  configuration.itemTextColor = .white

  let menuView = PopMenuView(dataArray: menus, origin: CGPoint(x: view.frame.width - 152, y: 80), size: CGSize(width: 130, height: 44), direction: .left, configuration: configuration)
  menuView.delegate = self
  return menuView
}()

// 弹出菜单
menuView.show()

// 实现代理方法
extension ViewController: PopMenuViewDelegate {
  func popMenuView(_ popMenuView: PopMenuView, didSelectRowAt index: Int, item: PopMenuItem) {
    print("点击了第 \(index) 个菜单, \(item.title)")
  }
}

```
### Example
![leftMenu](https://tva1.sinaimg.cn/large/007S8ZIlgy1gifsaw8muzj30pe1a00uc.jpg)

![rightMenu](https://tva1.sinaimg.cn/large/007S8ZIlgy1gifsbatqrvj30pe1a0myu.jpg)
