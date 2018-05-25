//
//  TwoTableViewCell.swift
//  Mall
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import YILTableViewManager

class TwoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = NSStringFromClass(TwoTableViewCell.self)

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

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

extension TwoTableViewCell: ViewStatusable {
    var modelManager: ModelManager? {
        get {
            return _modelManager
        }
        set(newValue) {
            _modelManager = newValue
        }
    }

//    typealias Element = [String: String]
    func config(_ viewStatus : ViewStatus, data: Any?) {
        self.selectionStyle = .none
        var title = "未知Title"
        var value = "未知value"
        var image = "优惠券"

        if let data = data as? [String: String] {
            title = data["title"] ?? "没有 Title"
            value = data["value"] ?? "没有 value"
            image = data["image"] ?? "优惠券"
        } else {
//            assert(false, "类型转换失败或 data 为空")
            switch viewStatus {
            case .idle:
                title = "idle Title"
                value = "idle value"
            case .loading:
                title = "loading Title"
                value = "loading value"
            case .success:
                title = "success Title"
                value = "success value"

            case .failure:
                title = "failure Title"
                value = "failure  value"
            }
        }
        var titleColor: UIColor = .gray
        var detailColor: UIColor = .gray
        switch viewStatus {
        case .idle:
            titleColor = .gray
            detailColor = .gray
        case .loading:
            titleColor = .darkGray
            detailColor = .darkGray
        case .success:
            titleColor = UIColor(red:0.09, green:0.56, blue:0.49, alpha:1.00)
            detailColor = UIColor(red:0.53, green:0.80, blue:0.39, alpha:1.00)

        case .failure:
            titleColor = UIColor(red:0.93, green:0.42, blue:0.09, alpha:1.00)
            detailColor = UIColor(red:0.93, green:0.42, blue:0.09, alpha:1.00)
        }
        titleLabel.textColor = titleColor
        contentLabel?.textColor = detailColor
        titleLabel?.text = title
        contentLabel?.text = value
        iconImageView?.image = UIImage(named:image)
    }
}
