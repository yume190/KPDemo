# KPDemo

運用 `KeyPath` 快速建立你的 Demo

---

## 安裝方式

``` ruby
pod 'KPDemo', :git => 'https://github.com/yume190/KPDemo', :tag => '0.0.4'
```

---

## [Demo APP](https://github.com/yume190/AdvanceAnimationDemo)

---

## 支援型態(預設 Cell)

`KPDemo` 會事先註冊下列 Cell，並依照 `KeyPath.Value` 查表，如果無符合項目，將會以 `DemoBasicCell` 呈現。

|`Cell`|`Type`|Extra Info|
|:-----|:-----|:---------|
|`DemoBoolCell`|`Bool`||
|`DemoCGRectCell`|`CGRect`|`Limit`|
|`DemoCGPointCell`|`CGPoint`|`Limit`|
|`DemoCGSizeCell`|`CGSize`|`Limit`|
|`DemoUIColorCell`|`UIColor`<br />`CGColor`||
|`DemoPrimtiveCell`|`Int, Int8, Int16, Int32, Int64`<br />`Float, Float32, Float64, Double, CGFloat`|`Limit`|

``` swift 
DemoItem(keyPath: \UIView.layer.masksToBounds)
DemoItem(keyPath: \UIView.frame)
DemoItem(keyPath: \UIView.frame.origin)
DemoItem(keyPath: \UIView.frame.size)
DemoItem(keyPath: \UIView.frame.backgroundColor)
DemoItem(keyPath: \UIView.layer.contentsScale, demoDescription: "@1x @2x @3x", info: .limit(.value1_3)),
```

---

## 特殊 Cell

### `DemoPickerCell`

``` swift
DemoItem(
    keyPath: \UIView.layer.contentsGravity,
    cell: DemoPickerCell.self,
    info: .table([
        CALayerContentsGravity.center: "center",
        CALayerContentsGravity.top: "top",
        CALayerContentsGravity.bottom: "bottom",
        CALayerContentsGravity.left: "left",
        CALayerContentsGravity.right: "right",
        CALayerContentsGravity.topLeft: "topLeft",
        CALayerContentsGravity.topRight: "topRight",
        CALayerContentsGravity.bottomLeft: "bottomLeft",
        CALayerContentsGravity.bottomRight: "bottomRight",
        CALayerContentsGravity.resize: "resize",
        CALayerContentsGravity.resizeAspect: "resizeAspect",
        CALayerContentsGravity.resizeAspectFill: "resizeAspectFill",
    ])
)
```

----

### OptionSet for `DemoOptionSetCell`

``` swift
struct Yume: OptionSet {
    let rawValue: Int

    static let nightmare = Yume(rawValue: 1)
    static let special = Yume(rawValue: 2)
    static let special2 = Yume(rawValue: 4)
}
DemoItem(
    keyPath: \UIView.yume,
    cell: DemoOptionSetCell<Yume>.self,
    info: .other([
        (Yume.nightmare, "nightmare"),
        (Yume.special, "special"),
    ])
,
```

----

### CaseIterable for `DemoEnumCell`

``` swift
enum Dream: CaseIterable {
    case a1
    case a2
    case a3
}
DemoItem(keyPath: \UIView.dream, cell: DemoEnumCell<Dream>.self)
```

---

## 指定 Cell

``` swift
DemoItem(keyPath: \UIView.dream, cell: DemoEnumCell<Dream>.self)
```

---

## 註冊 Cell 為預設 Cell

``` swift
class YourCell: UITableViewCell, DemoCellShowable, DemoCellRegistable {
    var getter: (() -> Any?)? = nil
    var setter: ((Any?) -> Void)? = nil
    func show<T>(showable: DemoShowable, item: Demo<T>) {}
    public static var registTypes: [Any.Type] {
        return [A.self, B.self]
    }
}

DemoConfig.register(cell: YourCell.self)
```
