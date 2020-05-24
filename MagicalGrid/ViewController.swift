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
        let width = info.width
        let height = info.width
        let jMax = Int(view.frame.height) / Int(width)
        for j in 0 ... jMax {
            
            for i in 0...info.rows {
                let itemView = makeItemView(i, width, j, height)
                view.addSubview(itemView)
            }
        }
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPanonView))
        view.addGestureRecognizer(panGesture)
        let longPressGesture = UILongPressGestureRecognizer(
            target: self, action: #selector(didTaponView))
        longPressGesture.minimumPressDuration = 0.1
        view.addGestureRecognizer(longPressGesture)
    }
    private var selectView:UIView? {
        didSet {
            if selectView != nil { view.bringSubviewToFront(selectView!) }
            if oldValue === selectView {return}
            if selectView != oldValue {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.selectView?.layer.transform = CATransform3DMakeScale(3, 3, 3)
                }, completion: nil)
                guard let oldValue = oldValue else {return}
                UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    oldValue.layer.transform = CATransform3DIdentity
                }, completion: nil)
            }
        }
    }
    
    private func getView(_ gesture:UIGestureRecognizer) -> UIView {
        let loction = gesture.location(in: view)
        let i = Int(loction.x / info.width)
        let j = Int(loction.y / info.width)
        let key = s(i,j)
        return viewDic[key]!
    }
    
    @objc
    private
    func didPanonView(_ gesture: UIPanGestureRecognizer) {
        let itemView = getView(gesture)
        if gesture.state == .ended {return selectView = nil}
        selectView = itemView
    }
    @objc private
    func didTaponView(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {return selectView = nil}
        let itemView = getView(gesture)
        selectView = itemView
    }
}

// MARK: - private Color builder
private func randomColor() ->UIColor {
    let (r,g,b) = (CGFloat(drand48()),CGFloat(drand48()),CGFloat(drand48()))
    return UIColor(red: r, green: g, blue: b, alpha: 1)
}

private struct ViewInfo {
    internal init(rows: Int, bound: CGRect) {
        self.rows = rows
        self.width =  bound.width / CGFloat(rows)
    }
    
    var rows:Int
    var width: CGFloat
}

private func s(_ i: Int...) -> String {
    i.map(String.init).joined(separator: ":")
}
private
var viewDic:[String: UIView] = [:]

private
func makeItemView(_ i: Int, _ width: CGFloat,
                  _ j: Int, _ height: CGFloat)-> UIView {
    let item = UIView()
    let a = s(i,j)
    viewDic[a] = item
    item.backgroundColor = randomColor()
    item.frame = CGRect(
        x: CGFloat(i) * width,
        y: CGFloat(j) * width,
        width: width,
        height: height)
    item.layer.borderWidth = 0.2
    item.layer.borderColor = UIColor.black.cgColor
    return item
}
