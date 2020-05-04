//
//  DemoSeperatorCell.swift
//  KPDemo
//
//  Created by Yume on 2020/4/30.
//  Copyright © 2020 Yume. All rights reserved.
//

import UIKit

public final class DemoSeperatorCell: UITableViewCell, DemoCellShowable {
    
    public let getter: (() -> Any?)? = nil
    public let setter: ((Any?) -> Void)? = nil
    
    private lazy var heightConstraint: NSLayoutConstraint = self._view.heightAnchor.constraint(equalToConstant: 0)
    
    private final lazy var _view: UIView = {
        let view = UIView()
        
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        return view
    }()
    
    public func show<T>(showable: DemoShowable, item: Demo<T>) {
        guard let seperator = showable as? SeperatorDemoItem else { return }
        self._view.backgroundColor = seperator.background
        self.heightConstraint.constant = seperator.height
        self.heightConstraint.isActive = true
    }
}
