//
//  Stack+Ex.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

extension UIStackView {
    public func arrange(views: [UIView]) {
        _ = views.map {self.addArrangedSubview($0)}
    }
    
    public static func custom(setting: ((UIStackView) -> Void)? = nil) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        setting?(stack)
        return stack
    }
    
    public static func customWithSwitch(title: String? = nil, tag: Int = 0) -> (stack: UIStackView, label: UILabel, switch: UISwitch) {
        let label = UILabel.custom { (label) in
            label.font = UIFont.systemFont(ofSize: 15)
            label.text = title
        }
        
        let _switch = UISwitch()
        _switch.tag = tag
        
        let stack = UIStackView.custom { (stack) in
            stack.arrange(views: [label, _switch])
        }
        return (stack, label, _switch)
    }
    
    public static func customWithSlider() -> (stack: UIStackView, label: UILabel, slider: UISlider) {
        let label = UILabel.custom { (label) in
            label.font = UIFont.systemFont(ofSize: 15)
        }
        
        let slider = UISlider.custom()
        
        let stack = UIStackView.custom { (stack) in
            stack.arrange(views: [label, slider])
        }
        return (stack, label, slider)
    }
    
//    private final lazy var widthValue: UISlider = UISlider.custom { (slider) in
//        slider.addTarget(self, action: #selector(self.widthing(sender:)), for: .valueChanged)
//    }
//    private final lazy var widthValueLabel: UILabel = UILabel.custom { (label) in
//        label.font = UIFont.systemFont(ofSize: 15)
//    }
//    private final lazy var widthStack: UIStackView = UIStackView.custom { (stack) in
//        stack.arrange(views: [
//            self.widthValueLabel,
//            self.widthValue,
//            ])
//    }
}

extension UILabel {
    public static func custom(setting: ((UILabel) -> Void)? = nil) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        setting?(label)
        return label
    }
}

extension UIStepper {
    public static func custom(setting: ((UIStepper) -> Void)? = nil) -> UIStepper {
        let stepper = UIStepper()
        stepper.maximumValue = 255
        stepper.minimumValue = 0
        stepper.stepValue = 1
        setting?(stepper)
        return stepper
    }
}

extension UISlider {
    public static func custom(setting: ((UISlider) -> Void)? = nil) -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 255
        slider.minimumValue = 0
        setting?(slider)
        return slider
    }
}

extension UITextField {
    static func custom(setting: ((UITextField) -> Void)? = nil) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        textField.delegate = ft
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        setting?(textField)
        return textField
    }
}

private var ft = FieldTemp()
private class FieldTemp: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//https://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
func unwrap(any: Any) -> Any {
    let mi = Mirror(reflecting: any)
    if mi.displayStyle != .optional {
        return any
    }
    
    return mi.children.first?.value ?? NSNull()
}


// https://stackoverflow.com/questions/15711645/how-to-get-uitableview-from-uitableviewcell
extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}


func andOptional<T>(_type: T.Type) -> [Any.Type] {
    return [T.self, Optional<T>.self]
}
