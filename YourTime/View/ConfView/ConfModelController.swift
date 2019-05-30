//
//  ConfModelController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/01.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import Foundation
//
//  ModelController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/05/07.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

/*
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ConfModelController: NSObject, UIPageViewControllerDataSource {
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> ConfDataViewController? {
        // Return the data view controller for the given index.
        if (ClockList.count() == 0) || (index >= ClockList.count()) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let confDataViewController = storyboard.instantiateViewController(withIdentifier: "ConfDataViewController") as! ConfDataViewController
        confDataViewController.index = index
        return confDataViewController
    }
    
    func indexOfViewController(_ viewController: ConfDataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return viewController.index
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ConfDataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ConfDataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == ClockList.count() {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

