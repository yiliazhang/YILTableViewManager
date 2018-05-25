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
    open var myAction: ((_ modelManager: ThreeModelManager, _ sender: Any) -> Void)?
}

class ThreeTableViewCell: UITableViewCell {


    static let reuseIdentifier: String = NSStringFromClass(ThreeTableViewCell.self)

    @IBAction func myAction(_ sender: Any) {
        
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
    //    typealias Element = [String: String]
    func config(_ viewStatus : ViewStatus, data: Any?) {
    }
}
