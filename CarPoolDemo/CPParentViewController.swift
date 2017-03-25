//
//  CPParentViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/23/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit

class CPParentViewController: UIPageViewController {

    //MARK:- View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        let childVC = viewController(atIndex: 0)
        setViewControllers([childVC], direction: .forward, animated: true, completion: nil)
        
        // Configure page indicator dot colors
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [CPParentViewController.self])
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = CPConstants.appGlobalColor
    }
    
    func viewController(atIndex index:Int) -> CPChildViewController {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "CPChildViewController") as! CPChildViewController
        viewController.index = index
        viewController.demoEntity = CPDataHandler.shared.demoEntities[index]
        return viewController
    }
}

extension CPParentViewController: UIPageViewControllerDataSource {
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        let controller = viewController as! CPChildViewController
        guard controller.index > 0 else {
            return nil
        }
        let currentIndex = controller.index - 1
        return self.viewController(atIndex: currentIndex)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        let controller = viewController as! CPChildViewController
        guard controller.index < 2 else {
            return nil
        }
        let currentIndex = controller.index + 1
        return self.viewController(atIndex: currentIndex)
    }
}
