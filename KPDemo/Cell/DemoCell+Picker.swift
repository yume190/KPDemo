//
//  DemoPickerCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/22.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoPickerCell: DemoBasicCell {
    private final lazy var value: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private final var table: [AnyHashable: String] = [:] {
        didSet {
            self.list = Array(self.table).sorted(by: { (l, r) -> Bool in
                l.key.description < r.key.description
            })
            self.anyList = self.list.map {$0.key}
            self.value.reloadAllComponents()
        }
    }
    private final var list: [(key: AnyHashable, value: String)] = []
    private final var anyList: [AnyHashable] = []
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        self.stack.addArrangedSubview(value)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        if case .table(let table) = showable.info {
            self.table = table
        }
    }
    
    final override func getValue() {
        super.getValue()
        
        guard let value = self.getter?() as? AnyHashable else {return}
        guard let index = anyList.firstIndex(of: value) else {return}
        self.value.selectRow(index, inComponent: 0, animated: false)
    }
}

extension DemoPickerCell: UIPickerViewDelegate {
    public final func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.list[row].value
    }
    
    public final func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setter?(self.list[row].key)
        self.getValue()
    }
}

extension DemoPickerCell: UIPickerViewDataSource {
    public final func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public final func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.list.count
    }
}
