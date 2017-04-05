//
//  CPSelectRideParentViewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/31/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

class CPSelectRideParentViewController: UIPageViewController {

    //MARK:- View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        let childVC = viewController(atIndex: 0)
        setViewControllers([childVC], direction: .forward, animated: true, completion: nil)
        
        // Configure page indicator dot colors
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [CPSelectRideParentViewController.self])
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = CPConstants.appGlobalColor
    }
    
    func viewController(atIndex index:Int) -> CPRideOptionVIewController {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "CPRideOptionVIewController") as! CPRideOptionVIewController
        viewController.index = index
        viewController.demoEntity = CPDataHandler.shared.rideOptionEntities[index]
        return viewController
    }
}

extension CPSelectRideParentViewController: UIPageViewControllerDataSource {
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        let controller = viewController as! CPRideOptionVIewController
        guard controller.index > 0 else {
            return nil
        }
        let currentIndex = controller.index - 1
        return self.viewController(atIndex: currentIndex)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        let controller = viewController as! CPRideOptionVIewController
        guard controller.index < 2 else {
            return nil
        }
        let currentIndex = controller.index + 1
        return self.viewController(atIndex: currentIndex)
    }

}
