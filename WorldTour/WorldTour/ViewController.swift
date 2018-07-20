//
//  ViewController.swift
//  WorldTour
//
//  Created by Jo JANGHUI on 2018. 7. 20..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import MapKit
import Colorify

class ViewController: UIViewController {
    
    let mapView = MKMapView()
    let scrollView = UIScrollView()
    let cityNum = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setView() //뷰의 색을 변경
        setMapView()
//        setScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setView() {
        view.backgroundColor = Colorify.Emerald
    }
    
    private func setMapView() {
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2) //뷰의 비율 수정할 때 사용
        
        let mapViewCoverButton = UIButton()
        mapViewCoverButton.frame = mapView.frame
        mapViewCoverButton.backgroundColor = UIColor(white: 1, alpha: 0.4)
        view.addSubview(mapView)
        view.addSubview(mapViewCoverButton)
    }
//    
//    private func setScrollView() {
//        let frameWidth = view.frame.width
//        let frameHeight = view.frame.height
//        let frameSize = view.frame.size
//        
//        let colorArr: [UIColor] = [.yellow, .blue, .white, .red]
//        
//        scrollView.frame.size = CGSize(width: frameWidth, height: frameWidth)
//        scrollView.center.x = view.center.x
//        scrollView.center.y = view.center.y
//        
//        for index in 0...3 {
//            let view1 = UIView(frame: CGRect(origin: CGPoint(x: frameWidth * CGFloat(index), y: 0), size: frameSize))
//            print(view1.frame)
//            view1.backgroundColor = colorArr[index]
//            scrollView.addSubview(view1)
//            print("d")
//        }
//        view.addSubview(scrollView)
//        
//        scrollView.contentSize = CGSize(width: frameWidth * 4, height: frameHeight)
//        
//        scrollView.isPagingEnabled = true
//        pageControl.frame = CGRect(
//            x: view.frame.midX - 20, y: view.frame.height - 60, width: 40, height: 20
//        )
//        pageControl.numberOfPages = 4
//    }
}

