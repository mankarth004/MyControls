//
//  DialPad.swift
//  DialPad
//
//  Created by SmartNet-MacBookPro on 10/8/18.
//  Copyright © 2018 kartheek.in. All rights reserved.
//

import UIKit
protocol DialPadDelegate: class {
    func dialPadNumberDidChange(_ number: String?)
}
@IBDesignable
class DialPad: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DialPadCellDelegate {

    fileprivate let buttonTitles = ["1","2","3","4","5","6","7","8","9","","0",""]
    
    var delegate: DialPadDelegate!
    
    fileprivate weak var collectionView: UICollectionView!
    
    @IBInspectable var buttonTitleColor: UIColor! = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var buttonBackground: UIColor! = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineColor: UIColor! = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var showLines: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var dialedNumber = "" {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setNeedsDisplay()
    }
    override func prepareForInterfaceBuilder() {
        setNeedsDisplay()
    }
    override func draw(_ rect: CGRect) {
        updateUI()
    }

    func updateUI() {
        if collectionView == nil {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
            let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.clear
            addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            let bundle = Bundle(for: DialPad.self)
            collectionView.register(UINib.init(nibName: "DialPadCell", bundle: bundle), forCellWithReuseIdentifier: "Cell")
            collectionView.delegate = self
            collectionView.dataSource = self
            self.collectionView = collectionView
        }
        if showLines {
            //            Draw vertical lines
            let yPos: CGFloat = 16.0
            let width = frame.width/3.0
            
            for index in 1...2 {
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: width*CGFloat(index), y: yPos))
                path.addLine(to: CGPoint(x: width*CGFloat(index), y: frame.height-yPos))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = lineColor.cgColor
                shapeLayer.lineWidth = 0.3
                
                layer.addSublayer(shapeLayer)
            }
            //            Draw horizontal lines
            let xPos: CGFloat = 16.0
            let height = frame.height/4.0
            
            for index in 1...3 {
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: xPos, y: height*CGFloat(index)))
                path.addLine(to: CGPoint(x: frame.width-xPos, y: height*CGFloat(index)))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = lineColor.cgColor
                shapeLayer.lineWidth = 0.3
                
                layer.addSublayer(shapeLayer)
            }
            
        }
    }
    
    //    MARK: - DialPadCellDelegate
    
    func buttonClicked(_ sender: UIButton) {
        if sender.tag == 12{
            dialedNumber = dialedNumber.substring(to: dialedNumber.index(before: dialedNumber.endIndex))
        }else if let buttonTitle = sender.title(for: .normal) {
            dialedNumber = dialedNumber+buttonTitle
        }
        delegate.dialPadNumberDidChange(dialedNumber)
    }
    //    MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DialPadCell
        let index = indexPath.row
        if index == 11 {
            let bundle = Bundle(for: DialPad.self)
            cell?.btnNumber.setImage(UIImage.init(named: "delete", in: bundle, compatibleWith: nil), for: .normal)
        }else{
            cell?.btnNumber.setImage(nil, for: .normal)
        }
        cell?.btnNumber.setTitle((index == 9 && index == 11) ? nil : buttonTitles[index], for: .normal)
        let width = frame.width/3
        cell?.btnNumber.layer.cornerRadius = (width*0.5)/2
        cell?.btnNumber.layer.masksToBounds = true
        cell?.btnNumber.backgroundColor = (index == 9 || index == 11) ? UIColor.clear : buttonBackground
        cell?.btnNumber.setTitleColor(buttonTitleColor, for: .normal)
        cell?.delegate = self
        cell?.btnNumber.tag = index+1
        return cell!
    }
    
    //    MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width/3
        
        return CGSize(width: width, height: frame.height/4)
    }
    
    //    MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
