//
//  DemoInformation.swift
//  KPDemo
//
//  Created by Yume on 2019/5/23.
//  Copyright © 2019 Yume. All rights reserved.
//

import Foundation

public enum DemoInfomation {
    case limit(Limit)
    case table([AnyHashable : String])
    case other(Any)
    case nothing
}
