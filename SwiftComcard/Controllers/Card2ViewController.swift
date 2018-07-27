//
//  Card2ViewController.swift
//  SwiftComcard
//
//  Created by Andesoft on 14/03/18.
//  Copyright © 2018 Andesoft. All rights reserved.
//

import UIKit
import MessageUI

class Card2ViewController: UIViewController,UIScrollViewDelegate,MFMailComposeViewControllerDelegate{

    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var scrollView1: UIScrollView!
    
    
    @IBOutlet weak var scrollView2: UIScrollView!
    
    
    @IBOutlet weak var scrollView3: UIScrollView!
    
    @IBOutlet weak var scrollView4: UIScrollView!
    
    
    @IBOutlet weak var scrollView5: UIScrollView!
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var modelHeight: UILabel!
    
    
    @IBOutlet weak var bustLabel: UILabel!
    
    
    @IBOutlet weak var waistLabel: UILabel!
    
    
    @IBOutlet weak var hipsLabel: UILabel!
    
    @IBOutlet weak var shoeLabel: UILabel!
    
    @IBOutlet weak var hairLabel: UILabel!
    
    @IBOutlet weak var eyeLabel: UILabel!
    
    
    @IBOutlet weak var imgView1: UIImageView!
    
    
    @IBOutlet weak var imgView2: UIImageView!
    
    @IBOutlet weak var imgView3: UIImageView!
    
    
    @IBOutlet weak var imgView4: UIImageView!
    
    @IBOutlet weak var imgView5: UIImageView!
    
    
    @IBOutlet weak var chestLabel: UILabel!
    
    
    @IBOutlet weak var bustLabel1: UILabel!
    
    
    
    @IBOutlet weak var picscrollView: UIScrollView!
    
    @IBOutlet weak var picHeaderView: UIView!
    
    weak var delegate: AddModelViewController?
    
    
    
    var mpuqid:String = "",
    muqid:String = "",
    model_name:String = "",
    job_uniueid:String = "",
    id_job_model:String = "",
    publishfile:String = "",
    imagepath:String = ""
    
    var data1 = NSData()
    
    var cnt:Int = 0,
    posx:Int = 10,
    posy:Int = 10,
    imgcnt:Int = 0
    
    
    var photompuqid = NSMutableArray()
    
    var isSaved:Bool = true
    
    
    var imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.defaultload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func defaultload(){
        
        
        
        picscrollView.isHidden = true
        
        innerView.backgroundColor = UIColor(red: 234, green: 233, blue: 231, alpha: 1.0)
        
        scrollView.contentSize = CGSize(width: 700, height: 500)
        
        commonLibrary().bordertoControl(control:scrollView1)
        commonLibrary().bordertoControl(control:scrollView2)
        commonLibrary().bordertoControl(control:scrollView3)
        commonLibrary().bordertoControl(control:scrollView4)
        commonLibrary().bordertoControl(control:scrollView5)

        scrollView1.maximumZoomScale = 0.5
        scrollView1.maximumZoomScale = 6.0
        scrollView1.contentSize = CGSize(width: 1280, height: 960)
        
        
        scrollView2.maximumZoomScale = 0.5
        scrollView2.maximumZoomScale = 6.0
        scrollView2.contentSize = CGSize(width: 1280, height: 960)
        
        
        scrollView3.maximumZoomScale = 0.5
        scrollView3.maximumZoomScale = 6.0
        scrollView3.contentSize = CGSize(width: 1280, height: 960)
        
        scrollView4.maximumZoomScale = 0.5
        scrollView4.maximumZoomScale = 6.0
        scrollView4.contentSize = CGSize(width: 1280, height: 960)
        
        scrollView5.maximumZoomScale = 0.5
        scrollView5.maximumZoomScale = 6.0
        scrollView5.contentSize = CGSize(width: 1280, height: 960)
        
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(self.gestureClicked))
        gesture1.numberOfTapsRequired = 1
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.gestureClicked))
        gesture2.numberOfTapsRequired = 1
        
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector(self.gestureClicked))
        gesture3.numberOfTapsRequired = 1
        
        let gesture4 = UITapGestureRecognizer(target: self, action:  #selector(self.gestureClicked))
        gesture4.numberOfTapsRequired = 1
        
        let gesture5 = UITapGestureRecognizer(target: self, action:  #selector(self.gestureClicked))
        gesture5.numberOfTapsRequired = 1
        
        imgView1.addGestureRecognizer(gesture1)
        imgView2.addGestureRecognizer(gesture2)
        imgView3.addGestureRecognizer(gesture3)
        imgView4.addGestureRecognizer(gesture4)
        imgView5.addGestureRecognizer(gesture5)
        
        let insertsql  = String(format:"select fname,height,bust,waist,hips,shoe,eye,hair,gender,muqid from model where muqid='%@';",commonLibrary().getModelUniqueId())
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        
        if(resultset.count > 0){
            
            for i in (0..<resultset.count){
                
                
                
                model_name = "\((resultset.value(forKey:"fname") as! NSArray).object(at:i) as! String)"
                muqid = "\((resultset.value(forKey:"muqid") as! NSArray).object(at:i) as! String)"
                
                modelLabel.text = model_name
                
                let gender = "\((resultset.value(forKey:"gender") as! NSArray).object(at:i) as! String)"
                bustLabel.text = "\((resultset.value(forKey:"bust") as! NSArray).object(at:i) as! String)"
                
                modelHeight.text = ":" + "\((resultset.value(forKey:"height") as! NSArray).object(at:i) as! String)"
                waistLabel.text = ":" + "\((resultset.value(forKey:"waist") as! NSArray).object(at:i) as! String)"
                hipsLabel.text = ":" + "\((resultset.value(forKey:"hips") as! NSArray).object(at:i) as! String)"
                shoeLabel.text = ":" + "\((resultset.value(forKey:"shoe") as! NSArray).object(at:i) as! String)"
                hairLabel.text = ":" + "\((resultset.value(forKey:"hair") as! NSArray).object(at:i) as! String)"
                eyeLabel.text = ":" + "\((resultset.value(forKey:"eye") as! NSArray).object(at:i) as! String)"

                
                
                if(gender=="Male"){
                    
                    bustLabel1.isHidden = true
                    chestLabel.isHidden = false
                    
                }
                else{
                    bustLabel1.isHidden = false
                    chestLabel.isHidden = true
                   
                    
                }
                
            }
        }
        
        
    }
    @objc func gestureClicked(sender : UITapGestureRecognizer) {
        do{
        posx = 10
        posy = 80
        imgcnt = 0
            
            
        imageView = sender.view as! UIImageView
            
        if(sender.view?.tag==1){
        self.scrollView1.setZoomScale(1.0, animated: true)
        
        }
        else if(sender.view?.tag==2){
            self.scrollView2.setZoomScale(1.0, animated: true)
            
        }
        else if(sender.view?.tag==3){
            self.scrollView3.setZoomScale(1.0, animated: true)
            
        }
        else if(sender.view?.tag==4){
            self.scrollView4.setZoomScale(1.0, animated: true)
            
        }
        else if(sender.view?.tag==5){
            self.scrollView5.setZoomScale(1.0, animated: true)
            
        }
        
        picscrollView.isHidden = false
            
            
        let insertsql  = String(format:"select mpuqid,muqid,file_path,file_name,is_active,createdby,createddt,createddt from model_picture where muqid='%@'and is_active=1;",commonLibrary().getModelUniqueId())
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        
        if(resultset.count > 0){
        
            for i in (0..<resultset.count){
            let filename  = "\((resultset.value(forKey:"file_name") as! NSArray).object(at:i) as! String)"
            
            mpuqid = "\((resultset.value(forKey:"mpuqid") as! NSArray).object(at:i) as! String)"
            muqid = "\((resultset.value(forKey:"muqid") as! NSArray).object(at:i) as! String)"
            
            
            let path1:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                
                
            let documentsDirectory = String(format:"%@/edited_images/",path1.object(at: 0) as! String)
            
            let filepath = documentsDirectory + filename
            
            let url = URL.init(fileURLWithPath: filepath)
            
            data1 = try NSData.init(contentsOf:url)
            
            if(imgcnt == 3){
                
                posy += 120;
                posx = 10;
                imgcnt = 0;
            }
            
            var button = UIButton()
            
            button = Design().createbutton(button: button, frame: CGRect(x:posx,y:posy,width:100,height:100), backgroundcolor: .white, title: "")
                

            button.addTarget(self, action:#selector(self.btnDetailsClick), for:.touchUpInside)
                
            button.setTitle(filename, for: .selected)
            
            button.setBackgroundImage(UIImage.init(data: data1 as Data), for: .normal)
            
            picscrollView .addSubview(button)
         
                posx += 110
                
                imgcnt += 1
            
            }
            }
            
            picscrollView.contentSize = CGSize(width: 0, height: 120*resultset.count)
        }
            catch{
                
                
            }
            
        }
    
     @objc func btnDetailsClick(sender: UIButton!) {
        do{
            
        picscrollView.isHidden = true
        headerView.isHidden = false
        scrollView.isHidden = false
            
        let path1:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = String(format:"%@/edited_images/",path1.object(at: 0) as! String)
        let filepath = documentsDirectory + sender.title(for: .selected)!
        
        photompuqid .add(filepath)
        
        
        let url = URL.init(fileURLWithPath: filepath)
        
        data1 = try NSData.init(contentsOf:url)
        
        
        imageView.image = UIImage.init(data: data1 as Data)
        
        }
        catch{
            
            
        }
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if(photompuqid.count>0){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.saveImg()
        }
        }
        else{
            
           let alert =  Design().invokeAlertMethod(strTitle:"" , strBody: "Please Select Image", delegate: self)
           alert.show()
        }
    }
    
    func saveImg(){
        do{
        let image = Design().makeImagefromView(view: self.innerView)
        let path1:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = String(format:"%@/edited_images/",path1.object(at: 0) as! String)
       
        
        let format = DateFormatter()
        format.dateFormat = "dd-MMM-yyyy HH_mm_ss_SSS"
        let now = Date()
        let imageName = String(format:"%@_%@",format .string(from: now),"temp.jpg")
        
        imagepath = documentsDirectory + imageName
        
        let imgData = UIImageJPEGRepresentation(image,1.0) as! NSData
        try imgData.write(to: URL(fileURLWithPath: imagepath), options: .atomic)
        
            let filedetails = NSMutableDictionary()
            
            filedetails.setValue("", forKey: "cuqid")
            filedetails.setValue(commonLibrary().getModelUniqueId(), forKey: "muqid")
            filedetails.setValue(imagepath, forKey: "file_path")
            filedetails.setValue(imageName, forKey: "file_name")
            filedetails.setValue("", forKey: "is_active")
            filedetails.setValue("", forKey: "createdby")
            filedetails.setValue(commonLibrary().getCurrentDateTimeSql(), forKey: "createddt")
            
            
            FunDrug().CardFiles(filedetails: filedetails)
            
            let alert = Design().invokeAlertMethod(strTitle: "", strBody: "Card has been saved", delegate: self)
            alert.show()
    }
        catch{
            
        }
    }
    @IBAction func btnSendMail(_ sender: UIButton) {
        
        let emailTitle = "Comcard for " + "\(model_name)" + "from Cocoaberry Ministry of Talent"
        
        let toRecipents : NSArray? = NSArray(objects:"prachi.jain@andesoftconsulting.com")
        
        let imgData = NSData.init(contentsOfFile: imagepath)
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(toRecipents as! [String])
        mailComposerVC.setSubject(emailTitle)
        mailComposerVC.setMessageBody("", isHTML: false)
        mailComposerVC.addAttachmentData(imgData as! Data, mimeType:"image/jpg" , fileName: (imagepath as NSString).lastPathComponent)
        self.present(mailComposerVC, animated:true, completion:nil)
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        
        delegate?.SendCardData()
        
        self.dismiss(animated:false, completion: nil)
        
    }
    
    @IBAction func btnPicBackClick(_ sender: UIButton) {
        
        picscrollView.isHidden = true
        scrollView.isHidden = false
        headerView.isHidden = false
        
    }
   
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        if(scrollView.tag==6){
        return self.imgView1
        }
        if(scrollView.tag==12){
            return self.imgView2
        }
        if(scrollView.tag==18){
            return self.imgView3
        }
        if(scrollView.tag==24){
            return self.imgView4
        }
        if(scrollView.tag==30){
            return self.imgView5
        }
        else{
        return nil
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
