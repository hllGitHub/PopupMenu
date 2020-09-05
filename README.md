# JHPopMenu
仿微信右上角弹出菜单

* 使用 Swift
* iOS 10.0, Swift 4.0+

## Using CocoaPods
``` ruby
pod 'JHPopMenu', '~> 0.0.2beta'
```

## Doc

### PopMenuConfiguration 支持多种自定义配置项

``` swift
public struct PopMenuConfiguration {
  var arrowSize: CGFloat = 10           // 箭头大小
  var arrowOffset: CGFloat = 20         // 箭头和目标视图的距离

  var animationDuration: Double = 0.15  // 动画时长
  var cornerRadius: CGFloat = 6         // 菜单的圆角
  var separatorColor: UIColor = .black  // 分割线颜色
  var fillColor: UIColor = UIColor(hexString: "#202B43")       // 菜单的背景填充色

  var itemFont: UIFont = UIFont.systemFont(ofSize: 16)         // 菜单项的字体
  var itemHeight: CGFloat = 44          // 菜单项的高度
  var itemTextColor: UIColor = .white   // 菜单项文本颜色
}
```

### 支持 delegate 和 block

* 可以选择实现 `PopMenuViewDelegate` 的协议方法，从而获取点击项相关事件
* 也可以选择使用 `PopMenuClickCallback`，即 `clickCallback` 直接调用

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
  // 可以选择 callback 的方式
    menuView.clickCallback = {(_, index, item) in
      print("第 \(index) 个 item, \(item)")
    }
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
