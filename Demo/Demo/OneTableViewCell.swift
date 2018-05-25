//
//  OneTableViewCell.swift
//  Mall
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import YILTableViewManager
// MARK: - cell
class OneTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = NSStringFromClass(OneTableViewCell.self)
    fileprivate var _modelManager: ModelManager?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension OneTableViewCell: ViewStatusable {

    var modelManager: ModelManager? {
        get {
            return _modelManager
        }
        set(newValue) {
            _modelManager = newValue
        }
    }

    func config(_ viewStatus : ViewStatus, data: Any?) {
        self.selectionStyle = .none
        var title = "未知Title"
        var value = "未知value"

        if let data = data as? [String: String] {
            title = data["title"] ?? "没有 Title"
            value = data["value"] ?? "没有 value"
        } else {
//            assert(false, "类型转换失败或 data 为空")
            switch viewStatus {
            case .idle:
                title = "idle Title"
                value = "idle value"
            case .loading:
                title = "loading Title"
                value = "loading value"
            case .successfull:
                title = "successfull Title"
                value = "successfull value"

            case .failure:
                title = "failure Title"
                value = "failure  value"
            }
        }
        textLabel?.text = title
        detailTextLabel?.text = value
    }
}
