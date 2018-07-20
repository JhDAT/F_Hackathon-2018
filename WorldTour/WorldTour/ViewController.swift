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
    
    private let mapView = MKMapView()
    private let scrollView = UIScrollView()
    private let cityNum:CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self
        
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
    
    private func setScrollView() {
        let frameWidth = view.frame.width
        
        scrollView.frame.size = CGSize(width: frameWidth, height: frameWidth)
        scrollView.center.x = view.center.x
        scrollView.center.y = view.center.y
        scrollView.showsHorizontalScrollIndicator = false
        for index in 0..<Int(cityNum) {
            //이미지뷰를 올릴 뷰
            
            let viewUnderImage = UIView(frame: CGRect(origin: CGPoint(x: scrollView.frame.width * CGFloat(index), y: 0), size: scrollView.frame.size))
            
            //이미지 뷰
            let cityImageView = UIImageView()
            cityImageView.frame.size = CGSize(width: viewUnderImage.frame.width - 20, height: viewUnderImage.frame.width - 20)
            cityImageView.frame.origin = CGPoint(x: 10, y: 10)
            cityImageView.contentMode = .scaleAspectFill
            cityImageView.image = UIImage(named: "seoul")
            //이미지 동그랗게
            cityImageView.layer.cornerRadius = cityImageView.frame.width/2
            cityImageView.layer.masksToBounds = true
            
            //이미지 뷰 색 보정
            let imageColorView = UIView()
            imageColorView.frame = cityImageView.frame
            imageColorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            imageColorView.layer.cornerRadius = cityImageView.frame.width/2
            imageColorView.layer.masksToBounds = true
            
            //이미지 위의 온도 등등
            //도시이름
            let cityName = UILabel()
            cityName.text = "Seoul"
            cityName.textColor = .white
            cityName.frame.size = CGSize(width: cityImageView.frame.width/2, height: cityImageView.frame.width/2)
            cityName.center.x = cityImageView.center.x
            cityName.center.y = cityImageView.center.y - 30
            cityName.textAlignment = .center
            cityName.font = UIFont(name: "Hiragino Maru Gothic ProN", size: 60)
            
            //온도 수
            let tempLabel = UILabel()
            tempLabel.text = "31"
            tempLabel.textColor = .white
            tempLabel.frame.size = CGSize(width: cityImageView.frame.width/2, height: cityImageView.frame.width/2)
            tempLabel.center.x = cityImageView.center.x - 25
            tempLabel.center.y = cityImageView.center.y + 100
            tempLabel.textAlignment = .center
            tempLabel.font = UIFont(name: "Hiragino Maru Gothic ProN", size: 40)
            
            //온도 이미지
            let celsiusImageView = UIImageView()
            celsiusImageView.frame.size = CGSize(width: 35, height: 35)
            celsiusImageView.center.x = cityImageView.center.x + 25
            celsiusImageView.center.y = tempLabel.center.y
            celsiusImageView.image = UIImage(named: "celsius")
            
            //이미지 뷰를 위한 버튼
            let cityImageButton = UIButton()
            cityImageButton.frame = cityImageView.frame
            cityImageButton.backgroundColor = UIColor(white: 0, alpha: 0)
            cityImageButton.layer.cornerRadius = cityImageView.frame.width/2
            cityImageButton.layer.masksToBounds = true
            cityImageButton.addTarget(self, action: #selector(tapImage(_:)), for: .touchUpInside)
            
            //뷰 올리기
            scrollView.addSubview(viewUnderImage)
            viewUnderImage.addSubview(cityImageView)
            viewUnderImage.addSubview(imageColorView)
            viewUnderImage.addSubview(tempLabel)
            viewUnderImage.addSubview(cityName)
            viewUnderImage.addSubview(celsiusImageView)
            viewUnderImage.addSubview(cityImageButton)
        }
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: frameWidth * cityNum, height: frameWidth)
        scrollView.isPagingEnabled = true
    }

    private func addPin(lat: Int, lon: Int) {
        let cityHall = MKPointAnnotation()
        cityHall.coordinate = CLLocationCoordinate2D(latitude: 37.566308, longitude: 126.977948)
        cityHall.title = "시청"
        cityHall.subtitle = "서울특별시"
        mapView.addAnnotation(cityHall)
    }
    
    @objc private func tapImage(_ sender: UIButton) {
        //상세 페이지로 넘어가기
        //print(scrollView.bounds)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        print(page)
    }
}
