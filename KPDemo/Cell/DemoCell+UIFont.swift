//
//  DemoCell+UIFont.swift
//  KPDemo
//
//  Created by Yume on 2020/4/29.
//  Copyright © 2020 Yume. All rights reserved.
//

import Foundation

public final class DemoUIFontCell: DemoBasicCell {
    fileprivate enum Style: CaseIterable {
        case normal
        case bold
        case italic
    }
    
    // MARK: UI
    private final lazy var style: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    private final lazy var size = UIStackView.customWithSlider()
    
    // MARK: Values
    //    font-family
    private final var _style: Style = .normal
    private final var _size: CGFloat = 0
    private final var _font: UIFont {
        //        switch _style {
        //        case .normal:
        //            /// font-family: ".SFUI-Regular"; font-weight: normal; font-style: normal; font-size: 1.00pt
        //            return .systemFont(ofSize: _size)
        //        case .bold:
        //            /// font-family: ".SFUI-Semibold"; font-weight: bold; font-style: normal; font-size: 1.00pt
        //            return .boldSystemFont(ofSize: _size)
        //        case .italic:
        //            /// font-family: ".SFUI-RegularItalic"; font-weight: normal; font-style: italic; font-size: 1.00pt
        //            return .italicSystemFont(ofSize: _size)
        //        }
        return .systemFont(ofSize: _size)
    }
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.style,
            self.size.stack
        ])
        self.size.slider.addTarget(self, action: #selector(self.valueing(sender:)), for: .valueChanged)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        //        self.value.slider.isHidden = !showable.isWritable
        
        size.slider.maximumValue = 100
        size.slider.minimumValue = 0
    }
    
    final override func getValue() {
        super.getValue()
        
        if let font = self.getter?() as? UIFont {
            self._size = font.pointSize
            self.size.label.text =
                .init(format: "size: %.2f", self._size)
            self.size.slider.value = Float(self._size)
            //            UIFontDescriptor.init().
            //            UIFontDescriptor.AttributeName.textStyle
            //                UIFont.TextStyle.
            //            UIFontDescriptor.AttributeName.
            //                UIFont.Weight
            //            self._value = value
            //
            //            self.value.label.text =
            //                String(format: "value: %.2f", self._value.floatValue)
            //
            //            self.value.slider.value = self._value.floatValue
        }
    }
}

// MARK: Actions
extension DemoUIFontCell {
    @objc
    private func valueing(sender: UISlider) {
        self._size = CGFloat(sender.value)
        self.setter?(self._font)
        self.getValue()
    }
}

extension DemoUIFontCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return [
            andOptional(_type: UIFont.self),
            ].flatMap {$0}
    }
}


extension DemoUIFontCell: UIPickerViewDelegate {
    
    public final func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(Style.allCases[row])"
    }
    
    public final func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self._style = Style.allCases[row]
        self.setter?(self._font)
        self.getValue()
    }
}

extension DemoUIFontCell: UIPickerViewDataSource {
    public final func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public final func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Style.allCases.count
    }
}
