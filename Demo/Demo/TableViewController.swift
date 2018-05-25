//
//  TableViewController.swift
//  Mall
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import YILTableViewManager
func delay(_ delay:Double, closure:@escaping()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}

class TableViewController: UITableViewController {

    var tableViewManager = TableViewManager()
    lazy var itemOne : ModelManager = {
        let manager = ModelManager("cellOne", cellReuseIdenfier: OneTableViewCell.reuseIdentifier, cellClassString: NSStringFromClass(OneTableViewCell.self))
        manager.didSelect = { [weak self] (tableView, indexPath, data) in
            if let strongSelf = self {
                let viewController = ViewController()
                if let data = data as? [String: String],
                    let title = data["title"] {
                    viewController.title = title
                }

                strongSelf.navigationController?.pushViewController(viewController, animated: true)
            }
            print("点我了")
        }

        return manager
    }()

    lazy var itemTwo : ModelManager = {
        return ModelManager("cellTwo", cellReuseIdenfier: TwoTableViewCell.reuseIdentifier, cellNib: UINib(nibName: "TwoTableViewCell", bundle: nil))
    }()

    lazy var itemThree : ThreeModelManager = {
        let manager =  ThreeModelManager("cellThree", cellReuseIdenfier: ThreeTableViewCell.reuseIdentifier, cellNib: UINib(nibName: "ThreeTableViewCell", bundle: nil))
        manager.myAction = {[weak self] (data, sender) in
            if let strongSelf = self {
                let alert = UIAlertController(title: "你点到我了！", message: "有什么需要吗？", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                strongSelf.navigationController?.present(alert, animated: true)
            }
        }
        return manager
    }()


    lazy var itemFour : ModelManager = {
        return ModelManager("cellFour", cellReuseIdenfier: OneTableViewCell.reuseIdentifier, cellClassString: NSStringFromClass(OneTableViewCell.self))
    }()


    lazy var itemFive : ModelManager = {
        return ModelManager("cellFive", cellReuseIdenfier: OneTableViewCell.reuseIdentifier, cellClassString: NSStringFromClass(OneTableViewCell.self))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "示例"
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableViewManager.tableView = tableView
        tableViewManager.append([itemOne, itemTwo, itemThree])

        updateOneItem(itemOne)
        updateTwoItem(itemTwo)

        ///tableViewManager insert 测试
//        delay(1) {
//            self.tableViewManager.insert(self.itemFive, at: 2)
//            self.tableViewManager.insert(self.itemSix, at: 3)
//            self.tableViewManager.insert(self.itemFive, at: 4)
//            self.tableView.reloadData()
//        }


        ///tableViewManager insert 测试
//        delay(1) {
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: 3)
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: 2)
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: -1)
//                        self.tableView.reloadData()
//        }


        ///tableViewManager insert 测试
//        delay(1) {
//            self.tableViewManager.remove(at: 1)
//            self.tableView.reloadData()
//        }

        ///tableViewManager removeSubrange 测试
//        delay(1) {
//            self.tableViewManager.removeSubrange(Range(uncheckedBounds: (3, 5)))
//            self.tableView.reloadData()
//        }

        ///tableViewManager remove 测试
//        delay(1) {
//           self.tableViewManager.remove(self.itemSix)
//            self.tableView.reloadData()
//        }

        ///tableViewManager removeAll 测试
//        delay(13) {
//            self.tableViewManager.removeAll()
//            self.tableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// itemOne 状态更新 测试
    func updateOneItem(_ item: ModelManager) {
        item[.idle] = ["title": "idle", "value": "-idle value-"]
        item[.loading] = ["title": "loading", "value": "-loading value-"]
        delay(2) {
            item.viewStatus = .loading
        }

        delay(6) {
            item[.successfull] = ["title": "successfull", "value": "-successfull value-"]
            item.viewStatus = .successfull
        }
    }

    /// itemTwo 状态更新 测试
    func updateTwo(_ item: ModelManager) {
        item[.idle] = ["title": "idle", "image": "汽车保养", "value": "-idle value-"]
        item[.loading] = ["title": "loading","image": "猜你喜欢", "value": ""]
        delay(3) {
            item.viewStatus = .loading
        }

        delay(7) {
            let value = "相比 MVC，MVP在层次划分上更加清晰了，不会出现一人身兼二职的情况（有些单元测试的童鞋，会发现单元测试用例更好写了）。在此处你可以看到 View 和 Model 之间是互不知道对方存在的，这样应对变更的好处更大，很多时候都是 View 层的变化，而 Model 层发生的变化会相对较少，遵循 MVP 的结构开发后，改起来代码来也没那么蛋疼。"
            item[.successfull] = ["title": "successfull", "image": "一站式服务", "value": value]
            item.viewStatus = .successfull
        }
    }

}
