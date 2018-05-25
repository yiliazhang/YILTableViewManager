//
//  Statusable.swift
//  Mall
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import UIKit

public enum ViewStatus: String {
    case idle = "idle"
    case loading = "loading"
    case successfull = "successfull"
    case failure = "failure"
}

public protocol ViewStatusable {
//    associatedtype Element: Modelable
//    func configStatus(viewStatus: ViewStatus, data: Element?)
    func config(_ viewStatus: ViewStatus, data: Any?)
}

open class ModelManager: NSObject {
    open var didSelect: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
//    open var didDeselect: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?

    fileprivate var  _viewStatus: ViewStatus = .idle

    open var viewStatus: ViewStatus {
        get {
            return _viewStatus
        }
        set {
            _viewStatus = newValue
            viewStatusString = newValue.rawValue
        }
    }

    @objc dynamic fileprivate var viewStatusString : String = ""

    fileprivate var _identifier = ""
    open var identifier: String {
        return _identifier
    }

    var _cellReuseIdentifier = ""
    open var cellReuseIdentifier: String {
        return _cellReuseIdentifier
    }

    var _cellClassString = ""
    open var cellClassString: String {
        return _cellClassString
    }

    var _cellNib: UINib?
    open var cellNib: UINib? {
        return _cellNib
    }

    var isNibForCell: Bool {
        return (_cellNib != nil)
    }

    var data: Any? {
        return itemWithViewStatus[viewStatus]
    }

//    private init(_ identifier: String, cellReuseIdenfier: String) {
//        self._cellReuseIdentifier = cellReuseIdenfier
//        if identifier.isEmpty {
//             let millisecond = CLongLong(round(Date().timeIntervalSince1970 * 1000))
//            self._identifier = millisecond.description
//        } else {
//            self._identifier = identifier
//        }
//    }

    public init(_ identifier: String, cellReuseIdenfier: String, cellClassString: String) {
//        self.init(identifier, cellReuseIdenfier: cellReuseIdenfier)
        self._cellReuseIdentifier = cellReuseIdenfier
        if identifier.isEmpty {
            let millisecond = CLongLong(round(Date().timeIntervalSince1970 * 1000))
            self._identifier = millisecond.description
        } else {
            self._identifier = identifier
        }
        self._cellClassString = cellClassString
    }

    public init(_ identifier: String, cellReuseIdenfier: String, cellNib: UINib) {
//        self.init(identifier, cellReuseIdenfier: cellReuseIdenfier)
        self._cellReuseIdentifier = cellReuseIdenfier
        if identifier.isEmpty {
            let millisecond = CLongLong(round(Date().timeIntervalSince1970 * 1000))
            self._identifier = millisecond.description
        } else {
            self._identifier = identifier
        }
        self._cellNib = cellNib
    }

    public var itemWithViewStatus: [ViewStatus: Any] = [:]
    public func config(_ data: Any?, forViewStatus: ViewStatus) {
        if let data = data {
            itemWithViewStatus[forViewStatus] = data
        } else {
            itemWithViewStatus.removeValue(forKey: forViewStatus)
        }
    }
}
