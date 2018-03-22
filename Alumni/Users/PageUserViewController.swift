//
//  PageUserViewController.swift
//  Alumni
//
//  Created by alumnos on 7/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class PageUserViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "userListViewController"),
                self.VCInstance(name: "userListViewController2")]
    }()
    
    private func VCInstance (name : String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        if let NewEventViewController = VCArr.first{
            setViewControllers([NewEventViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore ViewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = VCArr.index(of: ViewController) else{
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            //return VCArr.last
            return nil
            
        }
        guard VCArr.count > previousIndex else {
            return nil
        }
        return VCArr[previousIndex]
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = VCArr.index(of: viewController) else{
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArr.count else {
            //return VCArr.first
            return nil
        }
        guard VCArr.count > nextIndex else {
            return nil
        }
        return VCArr[nextIndex]
    }
    
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }
    
    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }
    
    
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return VCArr.count
    }
    
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCArr.index(of: firstViewController) else{
            return 0
        }
        
        return firstViewControllerIndex
        
        
    }
    
}
