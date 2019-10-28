//
//  ViewController.swift
//  Balloon-Slider
//
//  Created by Hasan Sedaghat on 10/28/19.
//  Copyright © 2019 Hasan Sedaghat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var ballonIMG: UIImageView!
    @IBOutlet var ballonLabel: UILabel!
    var frame: CGRect?
    var leftDistance: CGFloat?
    var scale: CGFloat = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.addTarget(self, action: #selector(didChangeSliderValue(sender:event:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(didBeginSlider(sender:)), for: .touchDown)
        slider.addTarget(self, action: #selector(didEndSlider(sender:)), for: [.touchUpInside,.touchUpOutside])
        self.slider.setThumbImage(#imageLiteral(resourceName: "OvalSelected"), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.ballonIMG.transform = CGAffineTransform(translationX: self.ballonIMG.frame.origin.x, y: 40).scaledBy(x: 0.1, y: 0.1)
        self.ballonLabel.transform = CGAffineTransform(translationX: self.ballonLabel.frame.origin.x, y: 40).scaledBy(x: 0.1, y: 0.1)
        self.ballonIMG.alpha = 0
        self.ballonLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        frame = self.view.convert((slider.subviews.last?.bounds)!, from: slider.subviews.last)
        leftDistance = frame!.origin.x
    }
    
    @objc func didBeginSlider(sender:UISlider) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.ballonIMG.transform = CGAffineTransform(translationX: self.frame!.origin.x - self.leftDistance!, y: 0).scaledBy(x: self.scale, y: self.scale)
            self.ballonLabel.transform = CGAffineTransform(translationX: self.frame!.origin.x - self.leftDistance!, y: 0).scaledBy(x: self.scale, y: self.scale)
            self.ballonIMG.alpha = 1
            self.ballonLabel.alpha = 1
            
        }, completion: nil)
        
        self.slider.subviews.last?.transform = CGAffineTransform(scaleX: 0.64, y: 0.64)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.slider.setThumbImage(#imageLiteral(resourceName: "Oval"), for: .normal)
            self.slider.subviews.last?.transform = .identity
        }, completion: nil)
    }
    
    @objc func didEndSlider(sender:UISlider) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut,.transitionCrossDissolve], animations: {
            self.ballonIMG.alpha = 0
            self.ballonLabel.alpha = 0
            self.ballonIMG.transform = CGAffineTransform(translationX: self.frame!.origin.x - self.leftDistance!, y: 40).rotated(by: 0).scaledBy(x: 0.5, y: 0.5)
            self.ballonLabel.transform = CGAffineTransform(translationX: self.frame!.origin.x - self.leftDistance!, y: 40).rotated(by: 0).scaledBy(x: 0.5, y: 0.5)
            
        }, completion: nil)
        
        self.slider.subviews.last?.transform = CGAffineTransform(scaleX: 1.55, y: 1.55)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut,.transitionCrossDissolve], animations: {
            self.slider.setThumbImage(#imageLiteral(resourceName: "OvalSelected"), for: .normal)
            self.slider.subviews.last?.transform = .identity
        }, completion: nil)
    }

    @objc func didChangeSliderValue(sender:UISlider,event:UIEvent) {
        let previousValue = Int(ballonLabel.text!)
        let minus = Int(sender.value) - previousValue!
        if minus != 0 {
            frame = self.view.convert((slider.subviews.last?.bounds)!, from: slider.subviews.last)
            
            var windValue = -10
            
            print(minus)
            var degrees: CGFloat = 0
            
            if Int(sender.value) < previousValue! {
                degrees = 10
                windValue = 10
            }
            else {
                degrees = 350
            }
            
            let radians: CGFloat = degrees * (.pi / 180)
            ballonLabel.text = "\(Int(slider.value))"
            scale = CGFloat((sender.value) / 400) + 1
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.ballonIMG.transform = CGAffineTransform(translationX: self.frame!.origin.x - self.leftDistance! + CGFloat(windValue), y: 0).scaledBy(x: self.scale, y: self.scale).rotated(by: radians)
                self.ballonLabel.transform = CGAffineTransform(translationX: self.frame!.origin.x - self.leftDistance! + CGFloat(windValue), y: 0).scaledBy(x: self.scale, y: self.scale).rotated(by: radians)
            }, completion:nil)
        }

    }
    
}
