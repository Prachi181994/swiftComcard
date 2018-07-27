//
//  commonLibrary.swift
//  SwiftComcard
//
//  Created by Andesoft on 01/03/18.
//  Copyright © 2018 Andesoft. All rights reserved.
//

import UIKit
import QuartzCore
class commonLibrary: NSObject {
    
    var defaults = UserDefaults.standard
    var model_id:String = "",
    tempid:String = "",
    job_Id:String = "",
    muqid:String = "",
    pub_id:String = "",
    jobUniqueId:String = ""
    
    
    func setModelID(idmodel:String){
       defaults .set(idmodel, forKey:"idmodel")
        model_id = idmodel
        
    }

    func getModelID() -> String{
        
        if((defaults.value(forKey:"idmodel")) != nil){
            
            model_id = defaults.value(forKey:"idmodel") as! String
        }
         return model_id
    }
    func setModelUniqueId(ModelUniqueId:String){
        defaults .set(ModelUniqueId, forKey:"muqid")
        muqid = ModelUniqueId
        
    }
    
    func getModelUniqueId() -> String{
        
        if((defaults.value(forKey:"muqid")) != nil){
            
            muqid = defaults.value(forKey:"muqid") as! String
        }
        return muqid
    }
    
    func setTemplateId(TemplateId:String){
        defaults .set(TemplateId, forKey:"tempid")
        tempid = TemplateId
        
    }
    
    func getTemplateId() -> String{
        
        if((defaults.value(forKey:"tempid")) != nil){
            
            tempid = defaults.value(forKey:"tempid") as! String
        }
        return tempid
    }
    func setJobId(JobId:String){
        defaults .set(JobId, forKey:"job_Id")
        job_Id = JobId
        
    }
    
    func getJobId() -> String{
        
        if((defaults.value(forKey:"job_Id")) != nil){
            
            job_Id = defaults.value(forKey:"job_Id") as! String
        }
        return job_Id
    }
    func setJobUniqueId(jobUnique_Id:String){
        defaults .set(jobUnique_Id, forKey:"jobUnique_Id")
        jobUniqueId = jobUnique_Id
        
    }
    
    func getJobUniqueId() -> String{
        
        if((defaults.value(forKey:"jobUniqueId")) != nil){
            
            jobUniqueId = defaults.value(forKey:"jobUniqueId") as! String
        }
        return jobUniqueId
    }
    func setPublishId(publishId:String){
        defaults .set(publishId, forKey:"publishId")
        pub_id = publishId
        
    }
    
    func getpublishId() -> String{
        
        if((defaults.value(forKey:"publishId")) != nil){
            
            pub_id = defaults.value(forKey:"publishId") as! String
        }
        return pub_id
    }
    
    
    func bordertoControl(control:UIScrollView){
        
        control.layer.borderWidth = 2
        control.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
    func saveImage(imageinfo:NSDictionary)->String{
        var imagepath:String = ""
        var imageName:String = imageinfo.object(forKey: UIImagePickerControllerReferenceURL) as! String
        imageName = (imageName as NSString).lastPathComponent
        let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = String(format:"%@/edited_images",path.object(at: 0) as! String)
        
        let format = DateFormatter()
        format.dateFormat = "dd-MMM-yyyy HH_mm_ss_SSS"
        let now = Date()
        var isDir  :ObjCBool = false
        let filemanager  = FileManager.default
        
        if !filemanager.fileExists(atPath: documentsDirectory, isDirectory:&isDir){
            do {
                try filemanager.createDirectory(atPath:documentsDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Couldn't create document directory")
            }
            
            if(imageName.count>0){
                imageName="presc.jpg"
            }
            imageName = String(format:"%@_%@",format .string(from: now),imageName)
            imagepath = documentsDirectory + imageName
            
            let mediatype :String = imageinfo .object(forKey: UIImagePickerControllerMediaType) as! String
            if(mediatype == "ALAssetTypePhoto"){
                
                let webdata:NSData  = compressImage(image:imageinfo .object(forKey: UIImagePickerControllerOriginalImage) as! UIImage)
                
                let filePathUrl = NSURL.fileURL(withPath: imagepath)
                webdata .write(to: filePathUrl, atomically: true)
                
            }
            else{
                let webdata:NSData  = compressImage(image:imageinfo .object(forKey: UIImagePickerControllerOriginalImage) as! UIImage)
                
                let filePathUrl = NSURL.fileURL(withPath: imagepath)
                webdata .write(to: filePathUrl, atomically: true)
                
            }
        
       
            
        }
         return imagepath
       
        }
        
        
    func compressImage(image:UIImage)->NSData{
            var actualHeight: Float = Float(image.size.height)
            var actualWidth: Float = Float(image.size.width)
            let maxHeight: Float = 300.0
            let maxWidth: Float = 400.0
            var imgRatio: Float = actualWidth / actualHeight
            let maxRatio: Float = maxWidth / maxHeight
            let compressionQuality: Float = 0.5
            //50 percent compression
            
            if actualHeight > maxHeight || actualWidth > maxWidth {
                if imgRatio < maxRatio {
                    //adjust width according to maxHeight
                    imgRatio = maxHeight / actualHeight
                    actualWidth = imgRatio * actualWidth
                    actualHeight = maxHeight
                }
                else if imgRatio > maxRatio {
                    //adjust height according to maxWidth
                    imgRatio = maxWidth / actualWidth
                    actualHeight = imgRatio * actualHeight
                    actualWidth = maxWidth
                }
                else {
                    actualHeight = maxHeight
                    actualWidth = maxWidth
                }
            }
            
            let rect = CGRect(x: 0, y: 0, width: CGFloat(actualWidth),height:  CGFloat(actualHeight))
            UIGraphicsBeginImageContext(rect.size)
            image.draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
            UIGraphicsEndImageContext()
           return imageData! as NSData
        }
    
    func getCurrentDateTime()->String{
        
        let now = Date()
        let format = DateFormatter()
        format .timeZone = NSTimeZone.default
        format.dateFormat = "dd LLLL yyyy"
        let nowdate = format .string(from: now)
        return nowdate
    }

    
    func getDateFromString(pstrDate:String)->String{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let passDate = format.date(from: pstrDate)
        format.dateFormat = "dd LLLL yyyy"
        let retDate = format.string(from: passDate!)
        return retDate
        
    }
    func getDatabaseDatetime() -> String {
         let format = DateFormatter()
         format.dateFormat = "dd LLLL yyyy"
         let date  = Date()
         return format .string(from: date)
    }
    func getCurrentDateTimeSql() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date  = Date()
        return format .string(from: date)
    }
}
