//
//  Design.swift
//  swiftdbPractise
//
//  Created by Andesoft on 28/02/18.
//  Copyright © 2018 Andesoft. All rights reserved.
//

import UIKit

class Design: NSObject {
    
    func createlabel(label:UILabel,frame:CGRect,textalignment:NSTextAlignment,value:String,backgroundcolor:UIColor) -> UILabel {
        let label:UILabel = label
        label.frame = frame
        label.textAlignment = textalignment
        label.text = value
        label.numberOfLines = 0;
        label .sizeToFit()
        label.backgroundColor = backgroundcolor
        return label
        
    }
    
    
    func showActivityIndicatory(uiView: UIView ,activityindicator:UIActivityIndicatorView) -> (UIActivityIndicatorView,UIView) {
        
        let container:UIView = UIView();
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.lightGray
        
        
        
        let loadingview:UIView = UIView();
        loadingview.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingview.center = uiView.center
        loadingview.backgroundColor = UIColor.darkGray
        loadingview.clipsToBounds = true
        loadingview.layer.cornerRadius = 10
        
        
        
        let activityindicator :UIActivityIndicatorView = activityindicator;
        activityindicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityindicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityindicator.center = CGPoint(x: loadingview.frame.size.width/2, y: loadingview.frame.size.width/2)
        
        
        loadingview.addSubview(activityindicator)
        container.addSubview(loadingview)
        uiView.addSubview(container)
        
        return (activityindicator,container)
        
    }
    
    
    func createbutton(button:UIButton,frame:CGRect,backgroundcolor:UIColor,title:String) -> UIButton {
        
        
        let button:UIButton = button
        button.frame = frame
        button.backgroundColor = backgroundcolor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
        
        
    }
    
    
    func createView(view:UIView,frame:CGRect,backgoroundcolor:UIColor)->UIView{
        
        let uiview:UIView = view
        uiview.frame = frame
        uiview.backgroundColor = backgoroundcolor
        return uiview
        
    }
    
    func makeImagefromView(view:UIView)->UIImage{
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image as! UIImage
    }
    
    func invokeAlertMethod(strTitle: NSString, strBody: NSString, delegate: AnyObject?)->UIAlertView
    {
        let alert: UIAlertView = UIAlertView()
        alert.message = strBody as String
        alert.title = strTitle as String
        alert.delegate = delegate
        alert.addButton(withTitle: "Ok")
        return alert
    }
}
