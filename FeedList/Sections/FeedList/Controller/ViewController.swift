//
//  ViewController.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

import UIKit

let cycleH: CGFloat = 300

class ViewController: UIViewController {
    
    private var layouts: [FeedListLayout] = [FeedListLayout]()
    
    private var playerManager: ZFAVPlayerManager = ZFAVPlayerManager()
    private var playerControlView: ZFPlayerControlView = ZFPlayerControlView()
    private var player: ZFPlayerController?
    private var playerCell: FeedListViewCell?
    
    private var lightContent: Bool = true
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return lightContent ? .lightContent : .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        request()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let player = player {
            player.isViewControllerDisappear = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.isViewControllerDisappear = true
        }
    }
    
    private func setup() {
        view.addSubview(tableView)
//        view.addSubview(cycleView)
//        cycleView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: cycleH)
//        tableView.contentInset = UIEdgeInsets(top: cycleH, left: 0, bottom: 0, right: 0)
        tableView.frame = view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
    }
    
    private func request() {
        DispatchQueue.global().async {
            for i in 0..<10 {
                let listM = FeedListModel()
                listM.content = " 苹果小贴士：如果你用苹果的触控板，看到任何你不认识的字，可以轻易的三指点按－就可以看到解说（词典或维基百科）。在这个示范可以看出这个功能还相当智能，我点选的是英文字，但它不止帮我找到了答案，还选择了中文！在 iPhone 上要多指点按并不精确，这也可能就是 Force Touch 的切入点。"
                if i % 4 == 0 {
                    listM.type = FeedListModelType.Pic.rawValue
                } else if i % 4 == 1 {
                    listM.type = FeedListModelType.None.rawValue
                    listM.content = "这天，老师如往常一样对着闹哄哄的班上大吼叫：“不——要——吵——啦！大家安静一点好不好？！"
                } else if i % 4 == 2 {
                    listM.type = FeedListModelType.Video.rawValue
                    listM.content = "这天，老师如往常一样对着闹哄哄的班上大吼叫：“不——要——吵——啦！大家安静一点好不好？！”全班没人理他，老师一气之下甩头就走，准备到校长那告状。当校长和老师两人怒气冲冲回到教室，正想开骂时，不料竟发现班上同学安安静静地坐着。“怎么啦？大家怎么变得这么乖？”"
                } else if i % 4 == 3 {
                    listM.type = FeedListModelType.Web.rawValue
                }
                listM.icon = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1027424821,3039895114&fm=26&gp=0.jpg"
                listM.name = "Kobe Bryant"
                listM.videoCover = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2448336203,2417907154&fm=26&gp=0.jpg"
                listM.images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184698&di=5c791f7577a3241d1b32c95c2c0e945a&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.zsnews.cn%2Fdata%2Fphoto%2FBackup%2F2014%2F10%2F14%2Ftw_201410149272178967.jpg",
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536589999056&di=54ae77e20512b0b0d89223e361193dd2&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2F11%2F1125%2F112523%2F11252316_1200x1000_0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536589830016&di=2c8ffa32dcba56ff91d7b2640bf81f51&imgtype=0&src=http%3A%2F%2Fimg.zybus.com%2Fuploads%2Fallimg%2F140704%2F1-140F4145036.jpg",
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536589830015&di=3313f8487b63f8add1f6b4d54e71e636&imgtype=0&src=http%3A%2F%2Fpic11.photophoto.cn%2F20090525%2F0036036395846248_b.jpg",
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536590017785&di=b1e6a45160744b0deee2ea6ad8ecacad&imgtype=0&src=http%3A%2F%2Fshihuo.hupucdn.com%2Fucditor%2F20180814%2F800x999_6a11f5303d8d3292e8b74f2e5a9c6a8f.jpeg",
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536590017785&di=4c2a144024e4fa95c5ffec6653c78cf6&imgtype=0&src=http%3A%2F%2Fpic37.nipic.com%2F20140116%2F9370446_131446661000_2.jpg",
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184549&di=4f0e3e4467f80b1a07bf2ec2a645347c&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.hinews.cn%2Fpic%2F0%2F11%2F43%2F80%2F11438010_485243.jpg",
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184586&di=d94923770f72493ec05a6808d635b058&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.hinews.cn%2Fpic%2F0%2F12%2F32%2F78%2F12327823_979870.jpg",
                                "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2996752772,1087629155&fm=26&gp=0.jpg"]
                listM.videoUrl = "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"
                listM.webTitle = " 苹果小贴士：如果你用苹果的触控板，看到任何你不认识的字，可以轻易的三指点按－就可以看到解说（词典或维基百科）。在这个示范可以看出这个功能还相当智能，我点选的是英文字，但它不止帮我找到了答案，还选择了中文！在 iPhone 上要多指点按并不精确，这也可能就是 Force Touch 的切入点。"
                listM.webUrl = "http://www.baidu.com"
                listM.webIcon = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184826&di=a47f6061230996d0773ff9fccfb94d0f&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.pychina.com%2FUpload%2FNews%2F2013-11-1%2F201311193455HZJ9E.jpg"
                listM.time = "1小时之前"
                listM.location = "北京·天安门"
                let layout = FeedListLayout()
                layout.listM = listM
                layout.layout()
                self.layouts.append(layout)
            }
            DispatchQueue.main.async {
                self.cycleView.images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184698&di=5c791f7577a3241d1b32c95c2c0e945a&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.zsnews.cn%2Fdata%2Fphoto%2FBackup%2F2014%2F10%2F14%2Ftw_201410149272178967.jpg",
                                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536589999056&di=54ae77e20512b0b0d89223e361193dd2&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2F11%2F1125%2F112523%2F11252316_1200x1000_0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536589830016&di=2c8ffa32dcba56ff91d7b2640bf81f51&imgtype=0&src=http%3A%2F%2Fimg.zybus.com%2Fuploads%2Fallimg%2F140704%2F1-140F4145036.jpg",
                                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536589830015&di=3313f8487b63f8add1f6b4d54e71e636&imgtype=0&src=http%3A%2F%2Fpic11.photophoto.cn%2F20090525%2F0036036395846248_b.jpg",
                                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536590017785&di=b1e6a45160744b0deee2ea6ad8ecacad&imgtype=0&src=http%3A%2F%2Fshihuo.hupucdn.com%2Fucditor%2F20180814%2F800x999_6a11f5303d8d3292e8b74f2e5a9c6a8f.jpeg",
                                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536590017785&di=4c2a144024e4fa95c5ffec6653c78cf6&imgtype=0&src=http%3A%2F%2Fpic37.nipic.com%2F20140116%2F9370446_131446661000_2.jpg",
                                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184549&di=4f0e3e4467f80b1a07bf2ec2a645347c&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.hinews.cn%2Fpic%2F0%2F11%2F43%2F80%2F11438010_485243.jpg",
                                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537184586&di=d94923770f72493ec05a6808d635b058&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.hinews.cn%2Fpic%2F0%2F12%2F32%2F78%2F12327823_979870.jpg",
                                         "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2996752772,1087629155&fm=26&gp=0.jpg"]
                self.self.tableView.reloadData()
            }
        }
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
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedRowHeight = 0
        table.showsVerticalScrollIndicator = true
        // table.contentInsetAdjustmentBehavior = .never
        table.register(FeedListViewCell.self, forCellReuseIdentifier: "FeedListViewCell")
        table.tableHeaderView = cycleView
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
        let cell = FeedListViewCell.cellWithTableView(tableView) as! FeedListViewCell
        cell.layout = layouts[indexPath.row]
        weak var self_ = self
        cell.openItemClickCallBack = { (cell: FeedListViewCell) in
            guard let self_ = self_ else { return }
            let offset = self_.tableView.contentOffset
            self_.tableView.reloadData()
            self_.tableView.contentOffset = offset
        }
        cell.picItemClickCallBack = { (cell: FeedListViewCell, pic: UIImageView, index: Int) in
            guard let self_ = self_ else { return }
            if let layout = cell.layout, let listM = layout.listM, let images = listM.images {
                var photoItems = [YYPhotoGroupItem]()
                for i in 0..<images.count {
                    let image = images[i];
                    let photoItem = YYPhotoGroupItem()
                    photoItem.thumbView = cell.pic.subviews[i];
                    photoItem.largeImageURL = URL(string: image)
                    photoItem.largeImageSize = UIScreen.main.bounds.size
                    photoItems.append(photoItem)
                }
                let fromView = pic
                let photoGroupV = YYPhotoGroupView(groupItems: photoItems)!
                photoGroupV.present(fromImageView: fromView, toContainer: self_.view, animated: true, completion: nil)
            }
        }
        cell.videoItemClickCallBack = {(cell: FeedListViewCell) in
            guard let self_ = self_ else { return }
            if let layout = cell.layout, let listM = layout.listM, let url = listM.videoUrl {
                if let player = self_.player {
                    player.stop()
                }
                self_.playerCell = cell
                self_.player = ZFPlayerController(playerManager: self_.playerManager, containerView: cell.video)
                self_.player!.controlView = self_.playerControlView
                self_.player!.assetURL = URL(string: url)!
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell == playerCell, let player = player {
            player.stop()
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        return
        let offsetY = scrollView.contentOffset.y
////
//        if offsetY <= -cycleH {
//            var rect = cycleView.frame
//            rect.origin.y = 0
////            rect.size.height = -offsetY
//            cycleView.frame = rect
//        } else {
//            var rect = cycleView.frame
//            rect.size.height = cycleH
//            rect.origin.y = -(cycleH + offsetY)
//            cycleView.frame = rect
//        }
        
        if offsetY <= -30 {
            lightContent = true
        } else {
            lightContent = false
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}
