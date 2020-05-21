//
//  ViewController.swift
//  MagicalGrid
//
//  Created by 游宗諭 on 2020/5/21.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit

struct ViewInfo {
    var rows:Int
    var columns:Int
    var bound: CGRect
    func width()-> CGFloat {
        bound.width / CGFloat(rows)
    }
    func height()-> CGFloat {
        bound.height / CGFloat(columns)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

// MARK: - private Color builder
private func randomColor() ->UIColor {
    let (r,g,b) = (CGFloat(drand48()),CGFloat(drand48()),CGFloat(drand48()))
    return UIColor(red: r, green: g, blue: b, alpha: 1)
}
