//
//  TwoTableViewCell.swift
//  Mall
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class TwoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = NSStringFromClass(TwoTableViewCell.self)

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

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
//    typealias Element = [String: String]
    func config(_ viewStatus : ViewStatus, data: Any?) {
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
            case .successfull:
                title = "successfull Title"
                value = "successfull value"

            case .failure:
                title = "failure Title"
                value = "failure  value"
            }
        }

        titleLabel?.text = title
        contentLabel?.text = value
        iconImageView?.image = UIImage(named:image)
    }
}
