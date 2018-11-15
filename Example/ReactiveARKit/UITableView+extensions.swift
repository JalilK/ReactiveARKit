//
//  UITableView+extensions.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register(cellClassWithXib cellClass: AnyClass) {
        let cellIdentifier = String(describing: cellClass)
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func register(cellClass: AnyClass?) {
        guard let cellClass = cellClass else { return }
        
        let cellIdentifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: cellIdentifier)
    }
    
    func dequeueReusableCell<T>() -> T? {
        let identifier = String(describing: T.self)
        let cell = dequeueReusableCell(withIdentifier: identifier)
        return cell as? T
    }
}
