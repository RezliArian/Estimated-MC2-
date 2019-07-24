//
//  CircularProgressBarView.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit


class CircularProgressBar: UIView {
  
  var progressPercent = 0
  
  //MARK: awakeFromNib
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
    label.text = "00 : 00 : 00"
  }
  
  
  //MARK: Public
  
  public var lineWidth:CGFloat = 40 {
    didSet{
      foregroundLayer.lineWidth = lineWidth
//      backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
      backgroundLayer.lineWidth = lineWidth
    }
  }
  
  public var labelSize: CGFloat = 20 {
    didSet {
      label.font = UIFont.systemFont(ofSize: labelSize, weight: .heavy)
      label.textColor = UIColor.white
      label.sizeToFit()
      configLabel()
    }
  }
  
  public var setLabel: String = "00 : 00 : 00" {
    didSet {
      label.text = setLabel
      configLabel()
    }
  }
  
  public var safePercent: Int = 100 {
    didSet{
      setForegroundLayerColorForSafePercent()
    }
  }
  
  public func setProgress(to progressConstant: Double, withAnimation: Bool) {
    
    var progress: Double {
      get {
        if progressConstant > 1 { return 1 }
        else if progressConstant < 0 { return 0 }
        else { return progressConstant }
      }
    }
    
    foregroundLayer.strokeEnd = CGFloat(progress)
    
    if withAnimation {
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.fromValue = 0
      animation.toValue = progress
      animation.duration = 2
      foregroundLayer.add(animation, forKey: "foregroundAnimation")
      
    }
    
    var currentTime:Double = 0
    let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
      if currentTime >= 2{
        timer.invalidate()
      } else {
        currentTime += 0.05
        let percent = currentTime / 2 * 100
        self.progressPercent = Int(progress * percent)
        self.setForegroundLayerColorForSafePercent()
        self.configLabel()
      }
    }
    timer.fire()
    
  }
  
  
  
  
  //MARK: Private
  private var label = UILabel()
  private let foregroundLayer = CAShapeLayer()
  private let middleLayer = CAShapeLayer()
  private let backgroundLayer = CAShapeLayer()
  
  private var radius: CGFloat {
    get {
      if self.frame.width < self.frame.height { return (self.frame.width - lineWidth) / 2 }
      else { return (self.frame.height - lineWidth) / 2 }
    }
  }
  
  private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
  
  private func makeBar(){
    self.layer.sublayers = nil
    drawBackgroundLayer()
    drawMiddleLayer()
    drawForegroundLayer()
  }

  
  private func drawBackgroundLayer(){
    let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    self.backgroundLayer.path = path.cgPath
    self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
    self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
    self.backgroundLayer.fillColor = UIColor.white.cgColor
    self.layer.addSublayer(backgroundLayer)
  }
  
  private func drawMiddleLayer() {
    let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius - 20, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    self.middleLayer.path = path.cgPath
    self.middleLayer.strokeColor = UIColor.gray.cgColor
    self.middleLayer.fillColor = UIColor.darkGray.cgColor
    self.layer.addSublayer(middleLayer)
  }
  
  private func drawForegroundLayer(){
    
    let startAngle = (-CGFloat.pi/2)
    let endAngle = 2 * CGFloat.pi + startAngle
    
    let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    self.foregroundLayer.lineCap = CAShapeLayerLineCap.round
    self.foregroundLayer.path = path.cgPath
    self.foregroundLayer.lineWidth = lineWidth - (lineWidth * 15/100)
    self.foregroundLayer.fillColor = UIColor.clear.cgColor
    self.foregroundLayer.strokeColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.7019607843, alpha: 1)
    self.foregroundLayer.strokeEnd = 0
    
    self.layer.addSublayer(foregroundLayer)
    
  }
  
  private func makeLabel(withText text: String) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    label.text = text
    label.font = UIFont.systemFont(ofSize: labelSize)
    label.sizeToFit()
    label.center = pathCenter
    return label
  }
  
  private func configLabel(){
    label.sizeToFit()
    label.center = pathCenter
  }
  
  private func setForegroundLayerColorForSafePercent(){
    
    if progressPercent >= self.safePercent {
      self.foregroundLayer.strokeColor = #colorLiteral(red: 0.3490196078, green: 0.09411764706, blue: 0.1882352941, alpha: 1)
    } else {
      self.foregroundLayer.strokeColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.7019607843, alpha: 1)
    }
  }
  
  private func setupView() {
    makeBar()
    self.addSubview(label)
  }
  
  
  
  //Layout Sublayers
  
  private var layoutDone = false
  override func layoutSublayers(of layer: CALayer) {
    if !layoutDone {
      let tempText = label.text
      setupView()
      label.text = tempText
      layoutDone = true
    }
  }
  
}
