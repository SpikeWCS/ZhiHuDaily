
import UIKit
struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}
class ViewController: UIViewController {
    // 主页导航控制器
    var mainNavigationController:UINavigationController!

    // 主页面控制器
    var mainViewController:MainViewController!
    
    // 菜单页控制器
    var menuViewController:MenuViewController?
    
    // 菜单页当前状态
    var currentState = MenuState.Collapsed {
        didSet {
            //菜单展开的时候，给主页面边缘添加阴影
            let shouldShowShadow = currentState != .Collapsed
            showShadowForMainViewController(shouldShowShadow: shouldShowShadow)
        }
    }
    
    // 菜单打开后主页在屏幕右侧露出部分的宽度
    let menuViewExpandedOffset: CGFloat = Device.width/2
    
    // 侧滑菜单黑色半透明遮罩层
    var blackCover: UIView?
    
    // 最小缩放比例
    let minProportion: CGFloat = 0.999
    
    // 导航栏左侧按钮
    var leftBarBtn: UIBarButtonItem!
    var leftBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化主视图
        mainNavigationController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "mainNavigaiton")
            as? UINavigationController
        view.addSubview(mainNavigationController.view)
        
        //指定Navigation Bar左侧按钮的事件
        mainViewController = mainNavigationController.viewControllers.first
            as? MainViewController

 //       leftBarBtn = UIBarButtonItem(image: UIImage(named: "daohanglan"), style: .done, target: self, action: #selector(showMenu))
        leftBarBtn = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(showMenu))
        leftBarBtn.tintColor = .black
        
        mainViewController.navigationItem.leftBarButtonItem = leftBarBtn
//        mainViewController.navigationItem.leftBarButtonItem?.image = UIImage(named: "daohanglan")
//        mainViewController.navigationItem.leftBarButtonItem?.action = #selector(showMenu)
//
        //添加拖动手势
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(handlePanGesture(_:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        //单击收起菜单手势
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(handleTapGesture))
        mainNavigationController.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //导航栏左侧按钮事件响应
    @objc func showMenu() {
        //如果菜单是展开的则会收起，否则就展开
        if currentState == .Expanded {
            animateMainView(shouldExpand: false)
        }else {
            addMenuViewController()
            animateMainView(shouldExpand: true)
        }
    }
    
    //拖动手势响应
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        
        switch(recognizer.state) {
        // 刚刚开始滑动
        case .began:
            // 判断拖动方向
            let dragFromLeftToRight = (recognizer.velocity(in: view).x > 0)
            // 如果刚刚开始滑动的时候还处于主页面，从左向右滑动加入侧面菜单
            if (currentState == .Collapsed && dragFromLeftToRight) {
                currentState = .Expanding
                addMenuViewController()
            }
            
        // 如果是正在滑动，则偏移主视图的坐标实现跟随手指位置移动
        case .changed:
            let screenWidth = view.bounds.size.width
            var centerX = recognizer.view!.center.x +
                recognizer.translation(in: view).x
            //页面滑到最左侧的话就不许要继续往左移动
            if centerX < screenWidth/2 { centerX = screenWidth/2 }
            
            // 计算缩放比例
            var proportion:CGFloat = (centerX - screenWidth/2) /
                (view.bounds.size.width - menuViewExpandedOffset)
            proportion = 1 - (1 - minProportion) * proportion
            
            // 执行视差特效
            blackCover?.alpha = (proportion - minProportion) / (1 - minProportion)
            
            //主页面滑到最左侧的话就不许要继续往左移动
            recognizer.view!.center.x = centerX
            recognizer.setTranslation(.zero, in: view)
            //缩放主页面
            recognizer.view!.transform = CGAffineTransform.identity
                .scaledBy(x: proportion, y: proportion)
            
        // 如果滑动结束
        case .ended:
            //根据页面滑动是否过半，判断后面是自动展开还是收缩
            let hasMovedhanHalfway = recognizer.view!.center.x > view.bounds.size.width
            animateMainView(shouldExpand: hasMovedhanHalfway)
        default:
            break
        }
    }
    
    //单击手势响应
    @objc func handleTapGesture() {
        //如果菜单是展开的点击主页部分则会收起
        if currentState == .Expanded {
            animateMainView(shouldExpand: false)
        }
    }
    
    // 添加菜单页
    func addMenuViewController() {
        if (menuViewController == nil) {
            menuViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "menuView")
                as? MenuViewController
            
            // 插入当前视图并置顶
            view.insertSubview(menuViewController!.view, at: 0)
            
            // 建立父子关系
            addChild(menuViewController!)
            menuViewController!.didMove(toParent: self)
            
            // 在侧滑菜单之上增加黑色遮罩层，目的是实现视差特效
            blackCover = UIView(frame: self.view.frame.offsetBy(dx: 0, dy: 0))
            blackCover!.backgroundColor = UIColor.black
            self.view.insertSubview(blackCover!,
                                    belowSubview: mainNavigationController.view)
        }
    }
    
    //主页自动展开、收起动画
    func animateMainView(shouldExpand: Bool) {
        // 如果是用来展开
        if (shouldExpand) {
            // 更新当前状态
            currentState = .Expanded
            // 动画
            let mainPosition = view.bounds.size.width * (1+minProportion/2)
                - menuViewExpandedOffset
            doTheAnimate(mainPosition: mainPosition, mainProportion: minProportion,
                         blackCoverAlpha: 0)
        }
            // 如果是用于隐藏
        else {
            // 动画
            doTheAnimate(mainPosition: view.bounds.size.width/2, mainProportion: 1,
                         blackCoverAlpha: 1) {
                finished in
                // 动画结束之后更新状态
                self.currentState = .Collapsed
                // 移除左侧视图
                self.menuViewController?.view.removeFromSuperview()
                // 释放内存
                self.menuViewController = nil;
                // 移除黑色遮罩层
                self.blackCover?.removeFromSuperview()
                // 释放内存
                self.blackCover = nil;
            }
        }
    }
    
    //主页移动动画、黑色遮罩层动画
    func doTheAnimate(mainPosition: CGFloat, mainProportion: CGFloat,
                      blackCoverAlpha: CGFloat, completion: ((Bool) -> Void)! = nil) {
        //usingSpringWithDamping：1.0表示没有弹簧震动动画
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0,
               initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.mainNavigationController.view.center.x = mainPosition
                self.blackCover?.alpha = blackCoverAlpha
                // 缩放主页面
                self.mainNavigationController.view.transform =
                    CGAffineTransform.identity.scaledBy(x: mainProportion, y: mainProportion)
        }, completion: completion)
    }
    
    //给主页面边缘添加、取消阴影
    func showShadowForMainViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            mainNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            mainNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// 菜单状态枚举
enum MenuState {
    case Collapsed  // 未显示(收起)
    case Expanding   // 展开中
    case Expanded   // 展开
}


