//
//  ViewController.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

import UIKit

let cycleH: CGFloat = 150

class ViewController: UIViewController {
    
    var layouts: [FeedListLayout] = [FeedListLayout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        request()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setup() {
        view.addSubview(tableView)
        view.addSubview(cycleView)
        cycleView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: cycleH)
    }
    
    private func request() {
        for i in 0..<10 {
            let listM = FeedListModel()
            listM.content = "这天，老师如往常一样对着闹哄哄的班上大吼叫：“不——要——吵——啦！大家安静一点好不好？！”全班没人理他，老师一气之下甩头就走，准备到校长那告状。当校长和老师两人怒气冲冲回到教室，正想开骂时，不料竟发现班上同学安安静静地坐着。“怎么啦？大家怎么变得这么乖？”老师不可置信地心中窃喜，“是发生了什么事吗？”一片鸦雀无声。“来！班长你说！”班长很不好意思地站起来，低着头嗫嚅着：“老，老师你说过‘如果有一天你进教室时发现全班都很安静的话……你就死给我们看……’”（现在的学生都这么皮滴么？？））"
            if i % 4 == 0 {
                listM.type = FeedListModelType.None.rawValue
            } else if i % 4 == 1 {
                listM.type = FeedListModelType.Pic.rawValue
                listM.content = "这天，老师如往常一样对着闹哄哄的班上大吼叫：“不——要——吵——啦！大家安静一点好不好？！"
            } else if i % 4 == 2 {
                listM.type = FeedListModelType.Video.rawValue
                listM.content = "这天，老师如往常一样对着闹哄哄的班上大吼叫：“不——要——吵——啦！大家安静一点好不好？！”全班没人理他，老师一气之下甩头就走，准备到校长那告状。当校长和老师两人怒气冲冲回到教室，正想开骂时，不料竟发现班上同学安安静静地坐着。“怎么啦？大家怎么变得这么乖？”"
            } else if i % 4 == 3 {
                listM.type = FeedListModelType.Web.rawValue
            }
            listM.icon = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"
            listM.name = "Charles"
            listM.videoUrl = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"
            listM.videoCover = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"
            listM.images = ["https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg",
                            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"]
            
            listM.webUrl = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"
            listM.webTitle = "一片鸦雀无声"
            listM.webIcon = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"
            listM.time = "1小时之前"
            let layout = FeedListLayout()
            layout.listM = listM
            layout.layout()
            layouts.append(layout)
        }
        cycleView.images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536919543&di=39441c7a1ef500b2be2c677814953105&imgtype=jpg&er=1&src=http%3A%2F%2Fpic22.photophoto.cn%2F20120225%2F0034034432152602_b.jpg",
                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536324824385&di=9a9da97eb980f8500f4d894cebe3da9a&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D4ecae4251530e924dba9947224610473%2Fb999a9014c086e065457c66608087bf40ad1cb24.jpg",
                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536324824382&di=79618d078697f8b3faf61392b0be3149&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3De4c50805b6315c60579863ace5d8a166%2F35a85edf8db1cb134d6f9803d754564e92584b9f.jpg"];
        
        tableView.reloadData()
    }
    
    // MARK: - Lazy
    
    lazy var cycleView: CycleScrollView = {
        let cycle = CycleScrollView()
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: cycleH)
        cycle.frame = frame
        return cycle
    }()
    
    lazy var tableView: UITableView = {
        let frame = view.bounds
        let table = UITableView(frame: frame, style: .plain)
        table.contentInset = UIEdgeInsets(top: cycleH, left: 0, bottom: 0, right: 0)
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedRowHeight = 0
        table.showsVerticalScrollIndicator = true
        table.contentInsetAdjustmentBehavior = .never
        table.register(FeedListViewCell.self, forCellReuseIdentifier: "FeedListViewCell")
        return table
    }()
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let layout = layouts[indexPath.row]
        return layout.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "FeedListViewCell") as? FeedListViewCell
        if cell == nil {
            cell = FeedListViewCell(style: .default, reuseIdentifier: "FeedListViewCell")
        }
        cell!.layout = layouts[indexPath.row]
        weak var self_ = self
        cell!.openItemClickCallBack = { (cell: FeedListViewCell) in
            guard let self_ = self_ else { return }
            let offset = self_.tableView.contentOffset
            self_.tableView.reloadData()
            self_.tableView.contentOffset = offset
        }
        cell!.picItemClickCallBack = { (cell: FeedListViewCell, pic: UIImageView, index: Int) in
//            guard let self_ = self_ else { return }
            
        }
        cell!.selectionStyle = .none
        return cell!
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY <= -cycleH {
            var rect = cycleView.frame
            rect.origin.y = 0
            rect.size.height = -offsetY
            cycleView.frame = rect
        } else {
            var rect = cycleView.frame
            rect.size.height = cycleH
            rect.origin.y = -(cycleH + offsetY)
            cycleView.frame = rect
        }
    }
}
