//
//  DemoOptionSetCell.swift
//  KPDemo
//
//  Created by Yume on 2019/5/24.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

fileprivate protocol DemoOptionSetCellDelegate: class {
    func select(index: Int, on: Bool)
}

fileprivate final class DemoOptionSetCellTemp: NSObject {
    weak var delegate: DemoOptionSetCellDelegate?
    @objc fileprivate final func switching(sender: UISwitch) {
        self.delegate?.select(index: sender.tag, on: sender.isOn)
    }
}

public final class DemoOptionSetCell<O: OptionSet>: DemoBasicCell, DemoOptionSetCellDelegate where O.RawValue: FixedWidthInteger, O == O.Element {
    
    private typealias UI = (stack: UIStackView, label: UILabel, switch: UISwitch)
    
    private final lazy var temp: DemoOptionSetCellTemp = {
        let temp = DemoOptionSetCellTemp()
        temp.delegate = self
        return temp
    }()
    
    private final var _value: O = O()
    private final var list: [(key: O, value: String)] = [] {
        didSet {
            self.table = Dictionary<O.RawValue, String>(uniqueKeysWithValues: self.list.map {($0.key.rawValue, $0.value)})
            self.uis = zip(self.list, self.list.indices).map { (data, index) in
                UIStackView.customWithSwitch(title: data.value, tag: index)
            }
        }
    }
    private final var table: [O.RawValue: String] = [:]
    private final var uis: [UI] = [] {
        didSet {
            _ = oldValue.map { $0.stack.removeFromSuperview() }
            self.stack.arrange(views: self.uis.map{$0.stack})
            _ = self.uis.map { (ui: UI) in
                ui.switch.addTarget(
                    self.temp,
                    action: #selector(DemoOptionSetCellTemp.switching(sender:)),
                    for: .valueChanged
                )
            }
        }
    }
    
    override public final func show<T>(showable: DemoShowable, item: Demo<T>) {
        super.show(showable: showable, item: item)
        guard case .other(let _list) = showable.info else {return}
        guard let list: [(key: O, value: String)] = _list as? [(key: O, value: String)] else {return}
        
        self.list = list
        self.getValue()
    }
    
    override final func getValue() {
        super.getValue()
        guard let value: O = self.getter?() as? O else {return}
        self._value = value
        
        for (ui, data) in zip(self.uis, self.list) {
            ui.switch.isOn = self._value.contains(data.key)
        }
    }
    
    fileprivate final func select(index: Int, on: Bool) {
        let target: O = self.list[index].key
        self._value = on ?
            self._value.union(target) :
            self._value.symmetricDifference(target)
        self.setter?(self._value)
        self.getValue()
    }
}
