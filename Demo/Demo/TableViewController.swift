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
        manager.didSelect = {(tableView, indexPath) in
            print("点我了")
        }

        return manager
    }()

    lazy var itemTwo : ModelManager = {
        return ModelManager("cellTwo", cellReuseIdenfier: TwoTableViewCell.reuseIdentifier, cellNib: UINib(nibName: "TwoTableViewCell", bundle: nil))
    }()

    lazy var itemThree : ThreeModelManager = {
        let manager =  ThreeModelManager("cellThree", cellReuseIdenfier: OneTableViewCell.reuseIdentifier, cellClassString: NSStringFromClass(OneTableViewCell.self))
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
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableViewManager.tableView = tableView
        tableViewManager.append([itemOne, itemTwo])

        itemThree.myAction = {(item, button) in
            print("点我了")
        }


        updateItemOne()
        updateItemTwo()
        updateItemThree()
//        delay(1) {
//            self.tableViewManager.insert(self.itemFive, at: 2)
//            self.tableViewManager.insert(self.itemSix, at: 3)
//            self.tableViewManager.insert(self.itemFive, at: 4)
//            self.tableView.reloadData()
//        }


//        delay(1) {
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: 3)
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: 2)
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: -1)
//                        self.tableView.reloadData()
//        }


//        delay(1) {
//            self.tableViewManager.remove(at: 1)
//            self.tableView.reloadData()
//        }

//        delay(1) {
//            self.tableViewManager.removeSubrange(Range(uncheckedBounds: (3, 5)))
//            self.tableView.reloadData()
//        }


//        delay(1) {
//           self.tableViewManager.remove(self.itemSix)
//            self.tableView.reloadData()
//        }
//        delay(13) {
//            self.tableViewManager.removeAll()
//            self.tableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateItemOne() {
        itemOne.config(["title": "idle", "value": "-idle value-"], forViewStatus: .idle)
        itemOne.config(["title": "loading", "value": "-loading value-"], forViewStatus: .loading)
        delay(2) {
            self.itemOne.viewStatus = .loading
        }

        delay(6) {
            self.itemOne.config(["title": "successfull", "value": "-successfull value-"], forViewStatus: .successfull)
            self.itemOne.viewStatus = .successfull
        }
    }


    func updateItemTwo() {
        itemTwo.config(["title": "idle", "image": "猜你喜欢", "value": "-idle value-"], forViewStatus: .idle)
        itemTwo.config(["title": "loading","image": "喷漆修复", "value": ""], forViewStatus: .loading)
        delay(3) {
            self.itemTwo.viewStatus = .loading
        }

        delay(7) {
            let value = "相比 MVC，MVP在层次划分上更加清晰了，不会出现一人身兼二职的情况（有些单元测试的童鞋，会发现单元测试用例更好写了）。在此处你可以看到 View 和 Model 之间是互不知道对方存在的，这样应对变更的好处更大，很多时候都是 View 层的变化，而 Model 层发生的变化会相对较少，遵循 MVP 的结构开发后，改起来代码来也没那么蛋疼。"
            self.itemTwo.config(["title": "successfull", "image": "赞同激活", "value": value], forViewStatus: .successfull)
            self.itemTwo.viewStatus = .successfull
        }
    }

    func updateItemThree() {
        itemThree.config(["title": "~~~idle", "value": "~~~-idle value-"], forViewStatus: .idle)
        itemThree.config(["title": "~~~loading", "value": "~~~-loading value-"], forViewStatus: .loading)
        delay(5) {
            self.itemThree.viewStatus = .loading
        }

        delay(8) {
            self.itemThree.config(["title": "~~~successfull", "value": "~~~-successfull value-"], forViewStatus: .successfull)
            self.itemThree.viewStatus = .successfull
        }
    }
}
