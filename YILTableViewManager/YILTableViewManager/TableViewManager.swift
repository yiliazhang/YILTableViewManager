//
//  TableViewManager.swift
//  Mall
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import UIKit

open class TableViewManager: NSObject {
   open weak var tableView: UITableView? {
        didSet {
            if let tableView = tableView {
                tableView.dataSource = self
                tableView.delegate = self
            }
        }
    }

    fileprivate let key = "viewStatusString"
    ///用户所有车辆
    fileprivate var _items: [ModelManager] = []

    deinit {
        _items.forEach { (item) in
            item.removeObserver(self, forKeyPath: key)
        }
    }

    open func insert(_ newElement: ModelManager, at: Int) {
        assert(at > 0, "index 必须 >= 0")

        newElement.addObserver(self, forKeyPath: key, options: [.new, .old], context: nil)
        if _items.count <= at {
            _items.append(newElement)
        } else {
            _items.insert(newElement, at: at)
        }
    }

    open func insert(_ newElements: [ModelManager], at: Int) {
        assert(at > 0, "index 必须 >= 0")
        if newElements.isEmpty {
            return
        }
        var index = at
        newElements.forEach { (item) in
            insert(item, at: index)
            index = index + 1
        }
    }

    open func remove(at: Int) {
        assert(at > 0, "index 必须 >= 0")
        if _items.count <= at {
            return
        }
        let item = _items[at]
        item.removeObserver(self, forKeyPath: key)
        _items.remove(at: at)
    }

    open func removeSubrange(_ range: Range<Int>) {
        for (index, item) in _items.enumerated().reversed() {
            if range.contains(index) {
                item.removeObserver(self, forKeyPath: key)
                _items.remove(at: index)
            }
        }
    }

    /// 注册数据
    open func append(_ newElement: ModelManager) {
        if !_items.contains(where: { (model) -> Bool in
            model.identifier == newElement.identifier
        }) {
            _items.append(newElement)
            if newElement.isNibForCell {
                if let nib = newElement.cellNib {
                    tableView?.register(nib, forCellReuseIdentifier: newElement.cellReuseIdentifier)
                } else {
                    assert(false, "nib 不存在")
                }
            } else {
                tableView?.register(NSClassFromString(newElement.cellClassString), forCellReuseIdentifier: newElement.cellReuseIdentifier)
            }

            newElement.addObserver(self, forKeyPath: key, options: [.new, .old], context: nil)
        } else {
            print("identifier： " + newElement.identifier + "已存在，请重新设置一个唯一 identifier")
        }
    }

    /// 注册数据组
    open func append(_ contentOf: [ModelManager]) {
        if contentOf.isEmpty {
            return
        }
        contentOf.forEach { (item) in
            append(item)
        }
    }


    ///移除所有
    open func removeAll() {
        _items.forEach { (model) in
            model.removeObserver(self, forKeyPath: "viewStatusString")
        }
        _items.removeAll()
    }

    ///移除 数据
    open func remove(_ element: ModelManager) {
        if let tmpItem = _items.first(where: { (model) -> Bool in
            model.identifier == element.identifier
        }) {
            tmpItem.removeObserver(self, forKeyPath: key)
        }

        _items = _items.filter({ (model) -> Bool in
            model.identifier != element.identifier
        })
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath,
            keyPath == "viewStatusString"  {

//            let oldValue = change![.oldKey] as? String
//            let newValue = change![.newKey] as? String

//            print("oldValue = \(oldValue),newValue = \(newValue)")
//            print("--------------")
//
//            print("keyPath = \(keyPath)")
//            print("object = \(object)")
//            print("change = \(change)")
//            print("context = \(context)")

            if let object = object as? ModelManager {
                    for (index, item) in _items.enumerated() {
                        if item.identifier == object.identifier {
                            tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                            break
                        }
                    }
                }
        }
    }
}

extension TableViewManager: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelManager = _items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: modelManager.cellReuseIdentifier)
        guard let cellOne = cell else {
            assert(cell != nil, "cell 不存在")
            return UITableViewCell()
        }

        if var cellTwo = cellOne as? ViewStatusable {
            cellTwo.modelManager = modelManager
            cellTwo.config(modelManager.viewStatus, data: modelManager.data)
        }

        return cellOne
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelManager = _items[indexPath.row]
        if modelManager.viewStatus != .successfull {
            return
        }
        if let didSelect = modelManager.didSelect {
            didSelect(tableView, indexPath, modelManager.data)
        }
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let modelManager = _items[indexPath.row]
//        if modelManager.viewStatus != .successfull {
//            return
//        }
//        if let didDeselect = modelManager.didDeselect {
//            didDeselect(tableView, indexPath)
//        }
    }
}

