//
//  Demo.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

//extension Demo: Demoable {}

public class AnyDemoable: NSObject, Demoable {
    public func setup(tableView: UITableView?) {}
}

public final class Demo<Target>: AnyDemoable, UITableViewDelegate, UITableViewDataSource {
    public final var target: Target
    public final let config: DemoConfig
    public final let items: [DemoShowable]
    public final let refresh: () -> Void
    public init(target: Target, config: DemoConfig, items: [DemoShowable], refresh: @escaping () -> Void = {}) {
        self.target = target
        self.config = config
        self.items = items
        self.refresh = refresh
        super.init()
    }
    
    private final weak var tableView: UITableView?
    public override final func setup(tableView: UITableView?) {
        self.tableView = tableView
        
        guard let tableView = self.tableView else {return}
        
        _ = self.items.map { (item: DemoShowable) in
            item.cell.registerClassTo(tableView: tableView)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private final func keyboardWillShow(notification: NSNotification) {
        guard let tableView: UITableView = self.tableView else {return}
        // read the CGRect from the notification (if any)
        let frame: Any? = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard let value: NSValue = frame as? NSValue else {return}
        let newFrame: CGRect = value.cgRectValue
        
        let insets: UIEdgeInsets =
            UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    @objc private final func keyboardWillHide(notification: NSNotification) {
        guard let tableView: UITableView = self.tableView else {return}
        // read the CGRect from the notification (if any)
        
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data: DemoShowable = items[indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: data.cell.identifier, for: indexPath)
        let cellShowable: DemoCellShowable? = cell as? DemoCellShowable
        cellShowable?.show(showable: data, item: self)
        return cell
    }
    
}
