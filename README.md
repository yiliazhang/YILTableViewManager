# YILTableViewManager

<p align="center">
<a href="https://travis-ci.org/yiliazhang/YILTableViewManager"><img src="https://travis-ci.org/yiliazhang/YILTableViewManager.svg?branch=master" alt="Build status" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat" alt="Swift 4 compatible" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
<a href="https://cocoapods.org/pods/YILTableViewManager"><img src="https://img.shields.io/cocoapods/v/YILTableViewManager.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/yiliazhang/YILTableViewManager/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
<a href="https://codebeat.co/projects/github-com-yiliazhang-YILTableViewManager"><img alt="codebeat badge" src="https://codebeat.co/badges/16f29afb-f072-4633-9497-333c6eb71263" /></a>
</p>



## Overview




git 项目地址[YILTableViewManager](https://github.com/yiliazhang/YILTableViewManager)

本库主要是针对，需要展示模块，但是模块数据没有获取到。针对获取数据的过程与结果等不同状态分别展现不同的 cell。

本案例中 数据一共有4个状态： `idle`    `loading`    `success`   `failure`

效果如图
![1.gif](https://upload-images.jianshu.io/upload_images/1484437-be4188104995d2c7.gif?imageMogr2/auto-orient/strip)

内部 UML 图

![uml.jpg](https://upload-images.jianshu.io/upload_images/1484437-40775489c718ddd3.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


使用方法
``` Swift
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
        return ModelManager("cellFour", cellReuseIdenfier: TwoTableViewCell.reuseIdentifier, cellNib: UINib(nibName: "TwoTableViewCell", bundle: nil))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "示例"
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableViewManager.tableView = tableView
        tableViewManager.append([itemOne, itemTwo, itemFour, itemThree])

        updateOneItem(itemOne)
        updateTwoItem(itemTwo)
        updateFourItem(itemFour)

        ///tableViewManager insert 测试
//        delay(1) {
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: 4)
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: 2)
//            self.tableViewManager.insert([self.itemFour, self.itemFive, self.itemSix], at: -1)
//            self.tableView.reloadData()
//        }


        ///tableViewManager remove 测试
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
        item[.loading] = ["title": "loading...", "value": "-loading value-"]
        delay(1.5) {
            item.viewStatus = .loading
        }

        delay(3) {
            item[.successfull] = ["title": "successfull", "value": "-successfull value-"]
            item.viewStatus = .successfull
        }
    }

    ///状态更新 测试
    func updateTwoItem(_ item: ModelManager) {
        item[.idle] = ["title": "idle", "image": "汽车保养", "value": "-idle value-"]
        item[.loading] = ["title": "loading","image": "猜你喜欢", "value": ""]
        delay(2) {
            item.viewStatus = .loading
        }

        delay(4) {
            let value = "相比 MVC，MVP在层次划分上更加清晰了，不会出现一人身兼二职的情况（有些单元测试的童鞋，会发现单元测试用例更好写了）。在此处你可以看到 View 和 Model 之间是互不知道对方存在的，这样应对变更的好处更大，很多时候都是 View 层的变化，而 Model 层发生的变化会相对较少，遵循 MVP 的结构开发后，改起来代码来也没那么蛋疼。"
            item[.successfull] = ["title": "successfull", "image": "一站式服务", "value": value]
            item.viewStatus = .successfull
        }
    }

    ///状态更新 测试
    func updateFourItem(_ item: ModelManager) {
        item[.idle] = ["title": "idle 状态", "image": "汽车保养", "value": "-idle value-"]
        item[.loading] = ["title": "loading...","image": "猜你喜欢", "value": ""]
        delay(3) {
            item.viewStatus = .loading
        }

        delay(5) {
            let value = "女孩子之所以会问一些奇奇怪怪的问题，其实只是想要自己的另一半承认自己最美最重要而已啊。你要是问“之前说过的话为什么还要反复说”，那就太单纯了。就像你为什么昨天吃过了饭今天还要吃一样，女孩子就是要不停地收到你对她的爱意，才会对感情充满安全感。"
            item[.failure] = ["title": "~ failure ~", "image": "汽车美容", "value": value]
            item.viewStatus = .failure
        }
    }

}

```


OneTableViewCell.swift
```
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
```
感谢支持 ：）



## Contents

* [Requirements]
* [Usage]
* [Custom rows]
* [Installation]
* [FAQ]

**For more information look at [our blog post] that introduces *YILTableViewManager*.**

## Requirements

* Xcode 9+
* Swift 4

### Example project

You can clone and run the Example project to see examples of most of YILTableViewManager's features.

## Usage

### How to create a form


## Installation

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

Specify YILTableViewManager into your project's `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'YILTableViewManager'
```

Then run the following command:

```bash
$ pod install
```

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

Specify YILTableViewManager into your project's `Cartfile`:

```ogdl
github "yiliazhang/YILTableViewManager" ~> 4.0
```

#### Manually as Embedded Framework

* Clone YILTableViewManager as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command from your project root git folder.

```bash
$ git submodule add https://github.com/yiliazhang/YILTableViewManager.git
```

* Open YILTableViewManager folder that was created by the previous git submodule command and drag the YILTableViewManager.xcodeproj into the Project Navigator of your application's Xcode project.

* Select the YILTableViewManager.xcodeproj in the Project Navigator and verify the deployment target matches with your application deployment target.

* Select your project in the Xcode Navigation and then select your application target from the sidebar. Next select the "General" tab and click on the + button under the "Embedded Binaries" section.

* Select `YILTableViewManager.framework` and we are done!



<!--- In file -->
[Introduction]: #introduction
[Requirements]: #requirements

[How to create a Form]: #how-to-create-a-form
[Getting row values]: #getting-row-values
[How to get the form values]: #how-to-get-the-form-values
[Examples]: #examples
[Usage]: #usage
[Operators]: #operators
[Rows]: #rows
[Using the callbacks]: #using-the-callbacks
[Section Header and Footer]: #section-header-and-footer
[Custom rows]: #custom-rows
[Basic custom rows]: #basic-custom-rows
[Custom inline rows]: #custom-inline-rows
[Custom presenter rows]: #custom-presenter-rows
[How to create custom inline rows]: #how-to-create-custom-inline-rows
[Custom rows catalog]: #custom-rows-catalog
[Dynamically hide and show rows (or sections)]: #hide-show-rows
[Implementing a custom Presenter row]: #custom-presenter-row
[Extensibility]: #extensibility
[Row catalog]: #row-catalog
[Installation]: #installation
[FAQ]: #faq

[List sections]: #list-sections
[Multivalued sections]: #multivalued-sections
[Validations]: #validations

<!--- In Project -->
[CustomCellsController]: Example/Example/ViewController.swift
[FormViewController]: Example/Source/Controllers.swift

# Donate to YILTableViewManager

So we can make YILTableViewManager even better!<br><br>
[<img src="donate.png"/>](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HRMAH7WZ4QQ8E)

# Change Log

This can be found in the [CHANGELOG.md](CHANGELOG.md) file.
