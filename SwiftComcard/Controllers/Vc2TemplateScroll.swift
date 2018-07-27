//
//  Vc2TemplateScroll.swift
//  SwiftComcard
//
//  Created by Andesoft on 05/04/18.
//  Copyright © 2018 Andesoft. All rights reserved.
//

import UIKit

class Vc2TemplateScroll: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var innerView: UIView!
    
    
    @IBOutlet weak var scrollView1: UIScrollView!
    
    
    @IBOutlet weak var scrollView2: UIScrollView!
    
    
    @IBOutlet weak var scrollView3: UIScrollView!
    
    
    @IBOutlet weak var scrollView4: UIScrollView!
    
    
    @IBOutlet weak var scrollView5: UIScrollView!
    
    
    
    @IBOutlet weak var imgView1: UIImageView!
    
    
    
    @IBOutlet weak var imgView2: UIImageView!
    
    
    @IBOutlet weak var imgView3: UIImageView!
    
    
    @IBOutlet weak var imgView4: UIImageView!
    
    @IBOutlet weak var imgView5: UIImageView!
    
    
    @IBOutlet weak var modelLabel: UILabel!
    
    
    @IBOutlet weak var modelHeight: UILabel!
    
    
    @IBOutlet weak var modelBust: UILabel!
    
    
    @IBOutlet weak var modelWaist: UILabel!
    
    
    @IBOutlet weak var modelHips: UILabel!
    
    
    @IBOutlet weak var modelShoe: UILabel!
    
    @IBOutlet weak var modelHair: UILabel!
    
    
    @IBOutlet weak var modelEyes: UILabel!
    
    
    @IBOutlet weak var picscrollView: UIScrollView!
    
    
    
    @IBOutlet weak var chestLabel: UILabel!
    
    
    @IBOutlet weak var bustLabel: UILabel!
    
    
    @IBOutlet weak var headerView: UIView!
    
    weak var delegate: AddModelViewController?
    
    
    var mpuqid:String = ""
    var muqid:String = ""
    var model_name:String = ""
    var publishfile:String = ""
    var job_uniqueid:String = ""
    var id_job_model:String = ""
    var imagepath:String = ""
    
    var photompuqid = NSMutableArray()
    var data1 = NSData()
    var imageView = UIImageView()
    var recieverA = Bool()
    
    
    var cnt :Int = 0
    var posx :Int = 0
    var posy :Int = 0
    var imgcnt :Int = 0
    
    
    
    
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
        chestLabel.isHidden = true
        bustLabel.isHidden = false
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
        
        let insertsql  = String(format:"select juqid from job where id_job='%@';",commonLibrary().getJobId())
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        
        if(resultset.count > 0){
     
            
            job_uniqueid = "\((resultset.value(forKey:"juqid") as! NSArray).object(at:0) as! String)"
            commonLibrary().setJobUniqueId(jobUnique_Id:job_uniqueid)
        }
        
        
        if(recieverA==true){
            
            let insertsql  = String(format:"select id_job_model,juqid,muqid,file_path from job_model where juqid='%@';",commonLibrary().getJobUniqueId())
            
            
            let resultset = DBManager().queryExecute(sqlQuery: insertsql)
            
            if(resultset.count > 0){
                id_job_model = "\((resultset.value(forKey:"id_job_model") as! NSArray).object(at:0) as! String)"
                job_uniqueid = "\((resultset.value(forKey:"juqid") as! NSArray).object(at:0) as! String)"
            }
            
        }
        
        
        let insertsql1  = String(format:"select fname,height,bust,waist,hips,shoe,eye,hair,gender,muqid from model where muqid='%@';",commonLibrary().getModelUniqueId())
        
        let resultset1 = DBManager().queryExecute(sqlQuery: insertsql1)
        
        if(resultset1.count > 0){
            
            for i in (0..<resultset1.count){
                
                
                
                model_name = "\((resultset1.value(forKey:"fname") as! NSArray).object(at:i) as! String)"
                muqid = "\((resultset1.value(forKey:"muqid") as! NSArray).object(at:i) as! String)"
                
                modelLabel.text = model_name
                
                let gender = "\((resultset1.value(forKey:"gender") as! NSArray).object(at:i) as! String)"
                bustLabel.text = "\((resultset1.value(forKey:"bust") as! NSArray).object(at:i) as! String)"
                
                modelHeight.text = ":" + "\((resultset1.value(forKey:"height") as! NSArray).object(at:i) as! String)"
                modelWaist.text = ":" + "\((resultset1.value(forKey:"waist") as! NSArray).object(at:i) as! String)"
                modelHips.text = ":" + "\((resultset1.value(forKey:"hips") as! NSArray).object(at:i) as! String)"
                modelShoe.text = ":" + "\((resultset1.value(forKey:"shoe") as! NSArray).object(at:i) as! String)"
                modelHair.text = ":" + "\((resultset1.value(forKey:"hair") as! NSArray).object(at:i) as! String)"
                modelEyes.text = ":" + "\((resultset1.value(forKey:"eye") as! NSArray).object(at:i) as! String)"
                
                
                
                if(gender=="Male"){
                    
                    bustLabel.isHidden = true
                    chestLabel.isHidden = false
                    
                }
                else{
                    bustLabel.isHidden = false
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
            headerView.isHidden = true
            scrollView.isHidden =  true
            
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
            
            photompuqid .add(mpuqid)
            
            
            let url = URL.init(fileURLWithPath: filepath)
            
            data1 = try NSData.init(contentsOf:url)
            
            
            imageView.image = UIImage.init(data: data1 as Data)
            
        }
        catch{
            
            
        }
    }
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        delegate?.SendCardData()
        
        self.dismiss(animated:false, completion: nil)
        
        
    }
    
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        
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
            if(recieverA==false){
            
            if(job_uniqueid != nil && muqid != nil ){
                
            
            
            filedetails.setValue("", forKey: "id_job_model")
            filedetails.setValue(job_uniqueid, forKey: "juqid")
            filedetails.setValue(muqid, forKey: "muqid")
            filedetails.setValue("", forKey: "is_active")
            filedetails.setValue("", forKey: "createdby")
            filedetails.setValue("", forKey: "createddt")
            filedetails.setValue(imagepath, forKey: "filepath")
            filedetails.setValue("0", forKey: "order")
                
            FunDrug().PhotFilesCU(filedetails: filedetails)
                
            for i in (0..<photompuqid.count){
        
                let DragfileDetails = NSMutableDictionary()
                
                DragfileDetails.setValue("", forKey: "jpuqid")
                DragfileDetails.setValue(job_uniqueid, forKey: "juqid")
                DragfileDetails.setValue(photompuqid .object(at:i) as! String, forKey: "mpuqid")
                DragfileDetails.setValue("", forKey: "order")
                DragfileDetails.setValue("", forKey: "filepath")
               
                FunDrug().DragPicturesFilesCU(filedetails:DragfileDetails)
            
                
                }
            
                
         
            let alert = Design().invokeAlertMethod(strTitle: "", strBody: "Card has been saved", delegate: self)
            alert.show()
            
                
                
            }
                
           
                
                /// reciever
            }
            else{
                
                if(id_job_model.count>0){
                    filedetails.setValue(id_job_model, forKey: "id_job_model")
                   
                    
                }
                else{
                    filedetails.setValue("", forKey: "id_job_model")
                    filedetails.setValue(job_uniqueid, forKey: "juqid")
                    filedetails.setValue(muqid, forKey: "muqid")
                    filedetails.setValue("", forKey: "createdby")
                    filedetails.setValue("", forKey: "createddt")
                    filedetails.setValue(imagepath, forKey: "filepath")
                    filedetails.setValue("0", forKey: "order")
                    
                    FunDrug().PhotFilesCU(filedetails: filedetails)
                    
                    
                    let alert = Design().invokeAlertMethod(strTitle: "", strBody: "Card has been saved", delegate: self)
                    alert.show()
                }
            }
            
        }
        catch{
            
        }
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
