//
//  ThreeTableViewCell.swift
//  Mall
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import YILTableViewManager
class ThreeModelManager: ModelManager {
    open var myAction: ((_ data: Any?, _ sender: Any) -> Void)?
}

class ThreeTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = NSStringFromClass(ThreeTableViewCell.self)

    fileprivate var _modelManager: ModelManager?

    @IBOutlet weak var contentLabel: UILabel!

    @IBAction func myAction(_ sender: Any) {
        if let modelManager = _modelManager as? ThreeModelManager,
            let myAction = modelManager.myAction {
            myAction(modelManager.data, sender)
        } else {
            assert(false, "模型未赋值或 与 cell  不匹配？")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ThreeTableViewCell: ViewStatusable {
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
    }
}
