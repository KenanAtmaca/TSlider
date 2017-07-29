//
//  TSlider
//  TSlider.swift
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//

import UIKit

enum theme {
    case white
    case gray
    case dark
}

enum style {
    case none
    case top
    case swipe
    case blur
}

class TSlider: NSObject {

    static let contentView = UIView()
    static let imageView = UIImageView()
    static let labelView = UILabel()
    static let pageControlView = UIPageControl()
    static let skipButton = UIButton()
    static var toView:UIView!
    
    static var images:[UIImage] = []
    static var titles:[String] = []
    
    private static var leftSwipeGesture:UISwipeGestureRecognizer!
    private static var rightSwipeGesture:UISwipeGestureRecognizer!
    
    static var pageIndex:Int = 0
    
    static var skip:(()->())? = nil
    
    static var animation:style = .none
    static var duration:TimeInterval = 1
    
    static var mode:theme = .white {
        didSet {
            if mode == .dark {
                self.imageView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                self.labelView.textColor = UIColor.white
                self.labelView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                self.pageControlView.currentPageIndicatorTintColor = UIColor.white
                self.skipButton.layer.borderColor = UIColor.white.cgColor
                self.skipButton.setTitleColor(UIColor.white, for: .normal)
            } else if mode == .gray {
                self.imageView.backgroundColor = UIColor.lightGray
                self.labelView.backgroundColor = UIColor.darkGray
                self.labelView.textColor = UIColor.lightGray
                self.pageControlView.currentPageIndicatorTintColor = UIColor.white
                self.skipButton.layer.borderColor = UIColor.darkGray.cgColor
                self.skipButton.setTitleColor(UIColor.darkGray, for: .normal)
            }
        }
    }
    
    static func add(to view:UIView) {
        
        toView = view
  
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white
        view.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        contentView.addSubview(imageView)

        imageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.5).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.font = UIFont(name: "Avenir", size: 25)
        labelView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        labelView.textAlignment = .center
        contentView.addSubview(labelView)
        
        labelView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: view.frame.height - view.frame.height / 1.5).isActive = true
        labelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        pageControlView.tintColor = UIColor.white
        pageControlView.pageIndicatorTintColor = UIColor.gray
        pageControlView.currentPageIndicatorTintColor = UIColor.black
        contentView.addSubview(pageControlView)
        
        pageControlView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5).isActive = true
        pageControlView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("x", for: .normal)
        skipButton.setTitleColor(UIColor.black, for: .normal)
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor.black.cgColor
        skipButton.layer.cornerRadius = 10
        skipButton.isHidden = true
        skipButton.addTarget(self, action: #selector(tapSkipButton), for: .touchUpInside)
        contentView.addSubview(skipButton)
        
        skipButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
        leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeContent(_:)))
        leftSwipeGesture.direction = .left
        
        rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeContent(_:)))
        rightSwipeGesture.direction = .right

        contentView.addGestureRecognizer(leftSwipeGesture)
        contentView.addGestureRecognizer(rightSwipeGesture)
        
        setup(pageIndex)
    }
    
    
    @objc static func tapSkipButton() {
        
        guard (skip != nil) else {
            fatalError("@Error Skip Button Handler Not Use!")
        }
        
        skip!()
    }
    
    @objc private static func swipeContent(_ sender:UISwipeGestureRecognizer) {
        
        setAnimation()
        
        if sender.direction == .left {
            
            if animation == .swipe {swipeAnimation("left")}
            
            if pageIndex < images.count - 1 {
                pageIndex += 1
            } else {
                pageIndex = 0
            }
            
        } else if sender.direction == .right {
            
            if animation == .swipe {swipeAnimation("right")}
            
            if pageIndex > 0 {
                pageIndex -= 1
            } else {
                pageIndex = images.count - 1
            }
        }
        
        setup(pageIndex)
    }
    
    private static func setup(_ index:Int) {
        
        pageControlView.numberOfPages = images.count
        pageControlView.currentPage = index
        
        imageView.alpha = 0.7
        labelView.alpha = 0.7
        
        if images.count > 0 {
            
           UIView.animate(withDuration: 0.3, animations: {
             self.imageView.image = self.images[index]
             self.labelView.text = self.titles[index]
             self.imageView.alpha = 1
             self.labelView.alpha = 1
           })
            
            if index == images.count - 1 {
                skipButton.isHidden = false
            } else {
                skipButton.isHidden = true
            }
        }
    }
   
    static func remove() {
        self.contentView.removeFromSuperview()
    }
    
    private static func setAnimation() {
        
        var imgTrans:CGAffineTransform!
        var labelTrans:CGAffineTransform!
        var pControlTrans:CGAffineTransform!
        
        if animation == .top {
            
            imgTrans = CGAffineTransform.init(translationX: 0, y: -toView.frame.height)
            labelTrans = CGAffineTransform.init(translationX: 0, y: toView.frame.height)
            pControlTrans = CGAffineTransform.init(translationX: 0, y: toView.frame.height)
            
            imageView.transform = imgTrans
            labelView.transform = labelTrans
            pageControlView.transform = pControlTrans
            
            UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
                self.imageView.transform = CGAffineTransform.identity
                self.labelView.transform = CGAffineTransform.identity
                self.pageControlView.transform = CGAffineTransform.identity
            }, completion: nil)
            
        } else if animation == .blur {
            
            let blurEffect = UIBlurEffect(style: .dark)
            
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = toView.frame
            
            contentView.addSubview(blurView)
            
           UIView.animate(withDuration: self.duration, animations: {
             blurView.effect = nil
             blurView.contentView.alpha = 0
           }, completion: { (_) in
             blurView.removeFromSuperview()
           })
            
        }
    }
    
    private static func swipeAnimation(_ pos:String) {
        
        var imgTransl:CGAffineTransform!
        var labelTransl:CGAffineTransform!
        var pControlTransl:CGAffineTransform!
       
        if pos == "right" {
            
            imgTransl = CGAffineTransform.init(translationX: -toView.frame.width, y: 0)
            labelTransl = CGAffineTransform.init(translationX: -toView.frame.width, y: 0)
            pControlTransl = CGAffineTransform.init(translationX: -toView.frame.width, y: 0)
            
            imageView.transform = imgTransl
            labelView.transform = labelTransl
            pageControlView.transform = pControlTransl
            
            UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                self.imageView.transform = CGAffineTransform.identity
                self.labelView.transform = CGAffineTransform.identity
                self.pageControlView.transform = CGAffineTransform.identity
            }, completion: nil)
            
            
        } else if pos == "left" {
            
            imgTransl = CGAffineTransform.init(translationX: toView.frame.width, y: 0)
            labelTransl = CGAffineTransform.init(translationX: toView.frame.width, y: 0)
            pControlTransl = CGAffineTransform.init(translationX: toView.frame.width, y: 0)
            
            imageView.transform = imgTransl
            labelView.transform = labelTransl
            pageControlView.transform = pControlTransl
            
            UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                self.imageView.transform = CGAffineTransform.identity
                self.labelView.transform = CGAffineTransform.identity
                self.pageControlView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
}//

