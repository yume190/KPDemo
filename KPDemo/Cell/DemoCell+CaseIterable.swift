//
//  DemoCell+CaseIterable.swift
//  KPDemo
//
//  Created by Yume on 2019/5/24.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoEnumCell<E: CaseIterable>: DemoBasicCell, UIPickerViewDelegate, UIPickerViewDataSource where E: Equatable {
    
    private final lazy var value: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private final var all = Array(E.allCases)
    
    final override public func setup() {
        super.setup()
        //        self.basicValueLabel.isHidden = true
        self.stack.addArrangedSubview(value)
    }
    
    override func getValue() {
        guard let value = self.getter?() as? E else {return}
        guard let index = self.all.firstIndex(of: value) else {return}
        self.value.selectRow(index, inComponent: 0, animated: false)
    }
    
    // MARK: UIPickerViewDelegate
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.all[row])"
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setter?(self.all[row])
        self.getValue()
    }
    
    // MARK: UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.all.count
    }
}
