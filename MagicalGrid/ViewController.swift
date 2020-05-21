//
//  ViewController.swift
//  MagicalGrid
//
//  Created by 游宗諭 on 2020/5/21.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    private
    lazy var info =  ViewInfo(rows: 15, bound: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = info.width()
        let height = info.width()
        let jMax = Int(view.frame.height) / Int(width)
        for j in 0 ... jMax {
            
            for i in 0...info.rows {
                let item = UIView()
                item.backgroundColor = randomColor()
                item.frame = CGRect(
                    x: CGFloat(i) * width,
                    y: CGFloat(j) * width,
                    width: width,
                    height: height)
                item.layer.borderWidth = 1
                item.layer.borderColor = UIColor.black.cgColor
                view.addSubview(item)
            }
        }
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPanOnView))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func didPanOnView(_ gesture: UIPanGestureRecognizer) {
        let loction = gesture.location(in: view)
        
    }
}

// MARK: - private Color builder
private func randomColor() ->UIColor {
    let (r,g,b) = (CGFloat(drand48()),CGFloat(drand48()),CGFloat(drand48()))
    return UIColor(red: r, green: g, blue: b, alpha: 1)
}

private struct ViewInfo {
    var rows:Int
    var bound: CGRect
    func width()-> CGFloat {
        bound.width / CGFloat(rows)
    }
}
