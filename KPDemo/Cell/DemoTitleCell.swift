//
//  DemoTitleCell.swift
//  KPDemo
//
//  Created by Yume on 2020/4/30.
//  Copyright © 2020 Yume. All rights reserved.
//

import UIKit

public final class DemoTitleCell: UITableViewCell, DemoCellShowable, DemoCellRegistable {
    
    private final lazy var titleLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: label.topAnchor, constant: -8).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -20).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20).isActive = true
    }
    
    public let getter: (() -> Any?)? = nil
    public let setter: ((Any?) -> Void)? = nil
    
    public static let registTypes: [Any.Type] = []
    
    func setup() {
        _ = self.titleLabel
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public func show<T>(showable: DemoShowable, item: Demo<T>) {
        titleLabel.text = showable.demoDescription
    }    
}
