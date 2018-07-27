
//
//  AddModelViewController.swift
//  SwiftComcard
//
//  Created by Andesoft on 24/01/17.
//  Copyright © 2017 Andesoft. All rights reserved.
//

import UIKit
import Photos
class AddModelViewController: UIViewController,UITextFieldDelegate {
    
    
    
    
    
    var modelname:String = ""
    var model_lastname:String = ""
    var modelheight:String = ""
    var modelbust:String = ""
    var modelwaist:String = ""
    var modelhips:String = ""
    var modelshoe:String = ""
    var modeleye:String = ""
    var modelhair:String = ""
    var modellastname:String = ""
    var muqid:String = ""
    var model_id:String = ""
    var filename:String = ""
    var filepath:String = ""
    var mpuqid:String = ""
    var id_model_picture:String = ""
    var reciever_id : String = ""
    var chest : String = ""
    var gender : String = ""
    var tuqid : String = ""
    var HeadingTitle : String = ""
    
    
    var posx :Int = 10;
    var posy :Int = 10;
    var imgcnt :Int = 0;
    var counter :Int = 0;
    
    
    var restrictview :Bool = true
    var reciverA  = Bool()
    var isCardCreated :Bool = false
    
    
    var activityindicator = UIActivityIndicatorView()
    var containerView = UIView()
    var imageAssets = [PHAsset]()
    
    
    var imgData = NSMutableArray()
    var fileNameArray = NSMutableArray()
    
    
    
    @IBOutlet weak var scrJobs: UIScrollView!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var jobtxtfield: UITextField!
    @IBOutlet weak var lblHistNo: UILabel!
    @IBOutlet weak var scrollPic: UIScrollView!
    
    
    @IBOutlet weak var selectedCount: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
   
    @IBOutlet weak var lnameTextfield: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var BustTextField: UITextField!
    
    @IBOutlet weak var WaistTextField: UITextField!
    
    
    @IBOutlet weak var HipsTextField: UITextField!
    
    @IBOutlet weak var ShoeTextField: UITextField!
  
    
    @IBOutlet weak var EyeTextField: UITextField!
    
    
    
    @IBOutlet weak var HairTextField: UITextField!
    
    
    
    
    @IBOutlet weak var InfoScrollView: UIScrollView!
    
    
    @IBOutlet weak var PictureView: UIView!
    
    
    @IBOutlet weak var JobHistView: UIView!
    
    
    
    
    @IBOutlet weak var btnJobHist: UIButton!
    
    
    
    
    @IBOutlet weak var btnHeading: UIButton!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var btnInfo: UIButton!
    
    
    
    @IBOutlet weak var info_border: UIView!
    
    @IBOutlet weak var btnPicture: UIButton!
    
    @IBOutlet weak var pic_border: UIView!
    
    @IBOutlet weak var history_border: UIView!
    
    
    @IBOutlet weak var gallery_view: UIView!
    
    @IBOutlet weak var gallery_scroll: UIScrollView!
    
    @IBOutlet weak var cards_border: UIView!
    
    @IBOutlet weak var scroll_card: UIScrollView!
    
    @IBOutlet weak var card_layer_scroll: UIScrollView!
    

    @IBOutlet weak var scroll_tabs: UIScrollView!
    
    @IBOutlet weak var male_radio: UIButton!
    
    @IBOutlet weak var female_radio: UIButton!
    
    @IBOutlet weak var bustlabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model_id = ""
        
        self.defaultload()
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(isCardCreated){
            
            self.createCardLayer()
        }
        // No need for semicolon
    }
    
    func defaultload(){
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.viewgestureClicked))
        self.view.addGestureRecognizer(gesture)
        
        pic_border.isHidden = true
        PictureView.isHidden = true
        
        history_border.isHidden = true
        JobHistView.isHidden = true
        
        scroll_card.isHidden = true
        cards_border.isHidden = true
        card_layer_scroll.isHidden = true
        
       scroll_tabs.contentSize = CGSize(width: 360, height: 60)
        
       InfoScrollView.contentSize = CGSize(width: 320, height: 60)
        
        scrollPic.contentSize = CGSize(width: 320, height: 60)
        
        chest="0"
        gender="Female"
        
        
        
        if(reciever_id.count>0){
            
            btnHeading.setTitle(HeadingTitle, for: .normal)
            
            let insertsql = String(format:"select muqid,fname,lname,height,bust,waist,hips,shoe,eye,hair,is_active,createdby,createddt,createddt,modifiedby,modifieddt,gender,chest from model where id_model='%@';",reciever_id)
            
            
            model_id = reciever_id
            
            
            
            let resultSet:NSMutableArray = DBManager().queryExecute(sqlQuery: insertsql)
            
            if(resultSet.count > 0){
                
                muqid = "\((resultSet.value(forKey:"muqid") as! NSArray).object(at:0) as! String)"
                nameTextField.text = "\((resultSet.value(forKey:"fname") as! NSArray).object(at:0) as! String)"
                heightTextField.text = "\((resultSet.value(forKey:"height") as! NSArray).object(at:0) as! String)"
                BustTextField.text = "\((resultSet.value(forKey:"bust") as! NSArray).object(at:0) as! String)"
                WaistTextField.text = "\((resultSet.value(forKey:"waist") as! NSArray).object(at:0) as! String)"
                HipsTextField.text = "\((resultSet.value(forKey:"hips") as! NSArray).object(at:0) as! String)"
                ShoeTextField.text = "\((resultSet.value(forKey:"shoe") as! NSArray).object(at:0) as! String)"
                EyeTextField.text = "\((resultSet.value(forKey:"eye") as! NSArray).object(at:0) as! String)"
                HairTextField.text = "\((resultSet.value(forKey:"hair") as! NSArray).object(at:0) as! String)"
                lnameTextfield.text = "\((resultSet.value(forKey:"muqid") as! NSArray).object(at:0) as! String)"

                let gender = "\((resultSet.value(forKey:"gender") as! NSArray).object(at:0) as! String)"
                
                if(gender=="Female"){
                    
                    bustlabel.text = "Bust:"
                    
                    
                    female_radio.setImage(UIImage.init(named:"radio-btn_checked"), for: .normal)
                
                    male_radio.setImage(UIImage.init(named:"radio-btn_unchecked"), for: .normal)
                    
                    chest = "0";
                    
                }
                else{
                    
                    bustlabel.text = "Chest:"
                    

                    male_radio.setImage(UIImage.init(named:"radio-btn_checked"), for: .normal)
                    
                    female_radio.setImage(UIImage.init(named:"radio-btn_unchecked"), for: .normal)
                    
                    chest = "1";
                    
                }
                
                
                
        }
        
        }
    }
    func SendCardData(){
        
        isCardCreated = true
        
    }
    
    
    func validateInfo() -> Bool{
        
        var isValid: Bool = true
        let modelDetails = NSMutableDictionary()
        
        isValid = self.txtFieldValidate(textField:nameTextField) && isValid ?true:false
        isValid = self.txtFieldValidate(textField:lnameTextfield) && isValid ?true:false
        isValid = self.txtFieldValidate(textField:heightTextField) && isValid ?true:false
        
        isValid = self.txtFieldValidate(textField:BustTextField) && isValid ?true:false
        
        isValid = self.txtFieldValidate(textField:WaistTextField) && isValid ?true:false
        isValid = self.txtFieldValidate(textField:HipsTextField) && isValid ?true:false
        isValid = self.txtFieldValidate(textField:ShoeTextField) && isValid ?true:false
        isValid = self.txtFieldValidate(textField:EyeTextField) && isValid ?true:false
        isValid = self.txtFieldValidate(textField:HairTextField) && isValid ?true:false
        
        if(isValid==true && model_id.count==0){
            
            modelname = nameTextField.text!;
            modellastname = lnameTextfield.text!
            modelheight = heightTextField.text!;
            modelbust = BustTextField.text!;
            modelwaist = WaistTextField.text!;
            modelhips = HipsTextField.text!;
            modelshoe = ShoeTextField.text!;
            modeleye = EyeTextField.text!;
            modelhair = HairTextField.text!;
            
            
            modelDetails.setValue("", forKey:"muqid")
            modelDetails.setValue(modelname, forKey:"fname")
            modelDetails.setValue(modelheight, forKey:"height")
            modelDetails.setValue(modelbust, forKey:"bust")
            modelDetails.setValue(modelwaist, forKey:"waist")
            
            
            
            modelDetails.setValue(modelhips, forKey:"hips")
            modelDetails.setValue(modelshoe, forKey:"shoe")
            modelDetails.setValue(modeleye, forKey:"eye")
            modelDetails.setValue(modelhair, forKey:"hair")
            modelDetails.setValue("1", forKey:"is_active")
            modelDetails.setValue("", forKey:"createdby")
            modelDetails.setValue("", forKey:"createddt")
            
            
            modelDetails.setValue("", forKey:"modifiedby")
            modelDetails.setValue("", forKey:"modifieddt")
            modelDetails.setValue(model_lastname, forKey:"lname")
            modelDetails.setValue(gender, forKey:"gender")
            modelDetails.setValue(chest, forKey:"chest")
            FunDrug().modelCu(modeldata: modelDetails)
            
            
            self.activityindicator.startAnimating()
            
           
            restrictview = true;
            
            let insertsql = String(format:"select muqid,fname,height,bust,waist,hips,shoe,eye,hair,is_active,createdby,createddt,createddt,modifiedby,modifieddt from model where id_model='%@';",commonLibrary().getModelID())
            
            
            
            let resultSet:NSMutableArray = DBManager().queryExecute(sqlQuery: insertsql)
            
            if(resultSet.count > 0){
                
                muqid = "\((resultSet.value(forKey:"muqid") as! NSArray).object(at:0) as! String)"
                model_id = muqid;
                
            }
            
            
        }
            
        else if(model_id.count>0 && isValid == true){
            
            model_id = muqid
            
            let editdetails = NSMutableDictionary()
            
            modelname = nameTextField.text!;
            modelheight = heightTextField.text!;
            modelbust = BustTextField.text!;
            modelwaist = WaistTextField.text!;
            modelhips = HipsTextField.text!;
            modelshoe = ShoeTextField.text!;
            modeleye = EyeTextField.text!;
            modelhair = HairTextField.text!;
            modellastname = lnameTextfield.text!
            
            editdetails.setValue(model_id, forKey:"id_model")
            editdetails.setValue(muqid, forKey:"muqid")
            editdetails.setValue(modelname, forKey:"fname")
            editdetails.setValue(modellastname, forKey:"lname")
            editdetails.setValue(modelheight, forKey:"height")
            editdetails.setValue(modelbust, forKey:"bust")
            editdetails.setValue(modelwaist, forKey:"waist")
            
            
            editdetails.setValue(modelhips, forKey:"hips")
            editdetails.setValue(modelshoe, forKey:"shoe")
            editdetails.setValue(modeleye, forKey:"eye")
            editdetails.setValue(modelhair, forKey:"hair")
            editdetails.setValue("1", forKey:"is_active")
            
            
            editdetails.setValue(gender, forKey:"gender")
            editdetails.setValue(chest, forKey:"chest")
            
            
            editdetails.setValue("", forKey:"createdby")
            editdetails.setValue("", forKey:"createddt")
            
            
            editdetails.setValue("", forKey:"modifiedby")
            editdetails.setValue("", forKey:"modifieddt")
            
            
            FunDrug().modelCu(modeldata: editdetails)
            
            
        }
        else{
            
            let alert =  Design().invokeAlertMethod(strTitle: "", strBody: "All fields are compulsory", delegate: nil)
            alert.show()
        }
        
        
        return isValid
    }
    
    @objc func viewgestureClicked(sender : UITapGestureRecognizer) {
        
        
        nameTextField.resignFirstResponder()
        lnameTextfield.resignFirstResponder()
        heightTextField.resignFirstResponder()
        BustTextField.resignFirstResponder()
        WaistTextField.resignFirstResponder()
        HipsTextField.resignFirstResponder()
        ShoeTextField.resignFirstResponder()
        EyeTextField.resignFirstResponder()
        HairTextField.resignFirstResponder()
    }
    
    @IBAction func btnBackClick( sender: UIButton) {
        
        self.dismiss(animated:false, completion:nil)
        
    }
    
    
    @IBAction func btnCardClick(_ sender: UIButton) {
        
        InfoScrollView.isHidden = true
        info_border.isHidden = true
        
        PictureView.isHidden = true
        pic_border.isHidden = true
        
        JobHistView.isHidden = true
        history_border.isHidden = true
        
        card_layer_scroll.isHidden = false
        scroll_card.isHidden = false
        cards_border.isHidden = false
       
        self.createCardLayer()
        
        
        
        
    }
    
    func createCardLayer(){
        do{
        for subview in self.scroll_card.subviews{
            subview.removeFromSuperview()
        }
        
        scroll_card.contentSize = CGSize(width: 320, height: 600)
        
        
        
        let insertsql = String(format:"select * from model_card where muqid ='%@' order by createddt desc limit 1;",muqid)
        
        
        
        let resultSet:NSMutableArray = DBManager().queryExecute(sqlQuery: insertsql)
        
        if(resultSet.count > 0){
            
            var filename = "\((resultSet.value(forKey:"file_path") as! NSArray).object(at:0) as! String)"
            
            filename = (filename as NSString).lastPathComponent
            
            let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            let documentsDirectory = path .object(at: 0) as! String
            
            let filepath1 = documentsDirectory + "/edited_images/" + filename
            
            let url = URL(fileURLWithPath: filepath1)
            
            let data = try Data(contentsOf:url)
            
            let image = UIImage(data:data)
            
            let imageview = UIImageView(image:image)
            imageview.frame = CGRect(x: 10, y: 10, width: scroll_card.frame.size.width - 20 , height: (scroll_card.frame.size.width - 20) * 0.70 )
            
            scroll_card.addSubview(imageview)
            
        }
        }
        catch{
            
            
        }
        
        
    }
    @IBAction func btn3layerClick(_ sender: UIButton) {
        commonLibrary().setTemplateId(TemplateId:"1")
        tuqid = "1"
        
    }
    
    
    @IBAction func btn5layerClick(_ sender: UIButton) {
        
        commonLibrary().setTemplateId(TemplateId:"2")
        tuqid = "2"
        commonLibrary().setModelUniqueId(ModelUniqueId: muqid)
        self.performSegue(withIdentifier:"CardpushTemplate2" , sender: self)
        
    }
    
    @IBAction func btn5layerClick2(_ sender: UIButton) {
        
        commonLibrary().setTemplateId(TemplateId:"3")
        tuqid = "3"
         commonLibrary().setModelUniqueId(ModelUniqueId: muqid)
        self.performSegue(withIdentifier:"CardpushTemplate3" , sender: self)
        
        
    }
    
    @IBAction func btnInfoClick( sender: UIButton) {
        
        
        PictureView.isHidden = true
        pic_border.isHidden = true
        
        JobHistView.isHidden = true
        history_border.isHidden = true
        
        
        InfoScrollView.isHidden = false;
        info_border.isHidden = false
        
        
        
        restrictview = true
        
        modelname = nameTextField.text!;
        modelheight = heightTextField.text!;
        modelbust = BustTextField.text!;
        modelwaist = WaistTextField.text!;
        modelhips = HipsTextField.text!;
        modelshoe = ShoeTextField.text!;
        modeleye = EyeTextField.text!;
        modelhair = HairTextField.text!;
        
        sender.tag = 1
        
        InfoScrollView .isScrollEnabled = true
        
        InfoScrollView.contentSize = CGSize(width:320, height: 600)
        
        
    }
    
    
    
    
    
    @IBAction func male_radio_click(_ sender: UIButton) {
        
        bustlabel.text = "Chest"
        gender = "Male"
        chest="1"
       
        
        male_radio.setImage(UIImage.init(named: "radio-btn_checked"), for: .normal)
        
        female_radio.setImage(UIImage.init(named: "radio-btn_unchecked"), for: .normal)
        
        if(model_id.count>0){
            female_radio.setImage(UIImage.init(named: "radio-btn_unchecked"), for: .normal)
            
        }
        
    }
    
    @IBAction func female_radio_click(_ sender: UIButton) {
        
        bustlabel.text = "Bust"
        gender = "Female"
        chest="0"
        
        
        female_radio.setImage(UIImage.init(named: "radio-btn_checked"), for: .normal)
        
        
        male_radio.setImage(UIImage.init(named: "radio-btn_unchecked"), for: .normal)
        
        if(model_id.count>0){
            male_radio.setImage(UIImage.init(named: "radio-btn_unchecked"), for: .normal)
            
        }
    }
    @IBAction func btnJobHistClick( sender: UIButton) {
        
        PictureView.isHidden = true
        
        JobHistView.isHidden = false
        
        InfoScrollView.isHidden = true
        
        pic_border.isHidden = true
        
        history_border.isHidden = true
        
        
        info_border.isHidden = true
        
      
        
        
        sender.tag = 3
        
        
        if(reciverA == true){
            
            JobHistView.isHidden = false
            btnAddItem.isHidden = false
            self.populatejobHist()
        }
        
        
        
    }
    
    func populatejobHist(){
        
        for subview in self.scrJobs.subviews{
            subview.removeFromSuperview()
        }
        
        var y:Int = 0
        let i:Int = 0
        
        let insertsql  = String(format:"select huqid,muqid,description,is_active,createdby,createddt,createddt from model_job_history where muqid='%@' and is_active=1",model_id)
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        lblHistNo.text = "\(i+1)"
        if(resultset.count > 0){
          
            for i in (0..<resultset.count){
                
              
                
                let HistoryUqid:String = "\((resultset.value(forKey:"huqid") as! NSArray).object(at:i) as! String)"
                var historydescription:String = "\((resultset.value(forKey:"description") as! NSArray).object(at:i) as! String)"
                
                var descriptionbtn = UIButton()
                
                descriptionbtn = Design().createbutton(button: descriptionbtn, frame:CGRect(x:0,y:y,width: Int(scrJobs.frame.size.width - 60),height:40), backgroundcolor:.white, title:"dsd")
                
                descriptionbtn.setTitle(historydescription, for: .disabled)
                
            
                descriptionbtn.layer.borderColor = UIColor.gray.cgColor
                
                historydescription = "\(i+1). " + "\(historydescription)"
                descriptionbtn.setTitle(historydescription, for: .normal)
                
                descriptionbtn.tag = (HistoryUqid as NSString).integerValue
                print(descriptionbtn.tag)
                
                
                
                descriptionbtn.setTitleColor(.black, for: .normal)
                descriptionbtn .contentHorizontalAlignment = .left
                descriptionbtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
                
                
                
                
                var deletebtn = UIButton()
                
                
                deletebtn = Design().createbutton(button: deletebtn, frame: CGRect(x:Int(scrJobs.frame.size.width - 60),y:y,width:60,height:40), backgroundcolor: .white, title: "")
                
                
                deletebtn.addTarget(self, action:#selector(historyDeleteClick), for:.touchUpInside)
                
                
                deletebtn.imageView?.contentMode = .scaleAspectFit
                
                deletebtn.setImage(UIImage.init(named:"delete_icon"), for:.normal)
                
                
                deletebtn.setTitle(HistoryUqid, for: .disabled)
                
                scrJobs .addSubview(descriptionbtn)
                scrJobs.addSubview(deletebtn)
                
                y+=42;
                lblHistNo.text = "\(i+2)"
            }
            
           
        }
        
        restrictview = false;
        
    }
    
    @objc func historyDeleteClick(_sender:UIButton) {
        
        let Historyuqid:String = _sender.title(for: .disabled)!
        
        let jobhistorydetails = NSMutableDictionary()
        
        jobhistorydetails .setValue(Historyuqid, forKey: "huqid")
        jobhistorydetails .setValue("", forKey: "muqid")
        jobhistorydetails .setValue("", forKey: "description")
        jobhistorydetails .setValue("0", forKey: "is_active")
        jobhistorydetails .setValue("", forKey: "createdby")
        jobhistorydetails .setValue("", forKey: "createddt")
        
        
        FunDrug().JobHistCU(jobhistdata: jobhistorydetails)
        
        
        self.populatejobHist()
        
        
    }
    
    
    func txtFieldValidate(textField:UITextField) -> Bool{
        
        if(textField.text?.characters.count == 0){
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1
            return false
            
        }
        
        return true
    }
    
    
    
    @IBAction func btnPicClick(_ sender: UIButton) {
        
        
        
        do{
            
            for subview in self.scrollPic.subviews{
                subview.removeFromSuperview()
            }
            
            posx = 10
            posy = 10
            imgcnt = 0
            
            
            let value = try validateInfo()
            if(value == false){
                return
            }
            
            InfoScrollView.isHidden = true
            JobHistView.isHidden = true
            
            PictureView.isHidden = false
            
            pic_border.isHidden = false
            
            history_border.isHidden = true
            
            info_border.isHidden = true
            
           
            
            
            
            
            if(reciever_id.count>0){
                
                let insertsql  = String(format:"select id_model_picture,mpuqid,muqid,file_path,file_name,is_active,createdby,createddt,createddt from model_picture where muqid='%@' and is_active=1;",reciever_id)
                
                let resultset = DBManager().queryExecute(sqlQuery: insertsql)
                
                if(resultset.count > 0){
                    
                    for i in (0..<resultset.count){
                        
                        
                        filename = "\((resultset.value(forKey:"file_name") as! NSArray).object(at:i) as! String)"
                        filepath = "\((resultset.value(forKey:"file_path") as! NSArray).object(at:i) as! String)"
                        mpuqid = "\((resultset.value(forKey:"mpuqid") as! NSArray).object(at:i) as! String)"
                        id_model_picture = "\((resultset.value(forKey:"mpuqid") as! NSArray).object(at:i) as! String)"
                        
                        let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                        let documentsDirectory = path .object(at: 0) as! String
                        
                        let filepath1 = documentsDirectory + "/edited_images/" + filename
                        
                        let url = URL(fileURLWithPath: filepath1)
                        
                        let data = try Data(contentsOf:url)
                        
                        let image = UIImage(data:data)
                        
                        if(imgcnt == 3){
                            
                            posy += 110;
                            posx = 10;
                            imgcnt = 0;
                        }
                        
                        let imageview = UIImageView(image:image)
                        imageview.contentMode = UIViewContentMode.scaleAspectFit
                        imageview.frame = CGRect(x: posx, y: posy, width: 100, height: 100)
                        imageview.isUserInteractionEnabled = true
                        
                        var deletebutton = UIButton()
                        deletebutton = Design().createbutton(button: deletebutton, frame:CGRect(x: 0, y: 0, width: 25, height: 25), backgroundcolor:.clear, title:"")
                        deletebutton.addTarget(self, action:#selector(btnPicDeleteClick), for:.touchUpInside)
                        deletebutton.isUserInteractionEnabled = true
                        deletebutton.setBackgroundImage(UIImage(named:"delete_icon"), for: .normal)
                        deletebutton.setTitle(mpuqid, for: .disabled)
                        deletebutton.setTitle(id_model_picture, for: .selected)
                        imageview .addSubview(deletebutton)
                        
                        scrollPic .addSubview(imageview)
                        
                        posx+=100
                        
                        imgcnt+=1
                        
                        
                        
                    }
                    
                }
                btnJobHist.isUserInteractionEnabled = true
            }
            
            self.view .endEditing(true)
        }
        catch{
            
            
        }
    }
    
     @objc func btnPicDeleteClick(sender: UIButton!) {
        let picturedeletedetails = NSMutableDictionary()
        picturedeletedetails.setValue(sender .title(for: .selected),forKey:"id_model_picture")
        picturedeletedetails.setValue(sender .title(for: .disabled), forKey:"mpuqid")
        picturedeletedetails.setValue(muqid, forKey:"muqid")
        picturedeletedetails.setValue("", forKey:"filepath")
        picturedeletedetails.setValue("", forKey:"filename")
        picturedeletedetails.setValue("0", forKey:"is_active")
        picturedeletedetails.setValue("", forKey:"createdby")
        picturedeletedetails.setValue("", forKey:"createddt")
        FunDrug().picturesfileCu(filedetails:picturedeletedetails)
        
        
        let imageview = sender.superview as! UIImageView
        imageview .removeFromSuperview()
        
    }
    @IBAction func btnAddItem(_ sender: UIButton) {
        
        let valid:Bool = true
        
        let jobhistorydetails = NSMutableDictionary()
        
        
        let jobhisttext = jobtxtfield.text
        
        jobhistorydetails.setValue("", forKey:"huqid")
        
        if(jobtxtfield.tag>0){
            
            jobhistorydetails.setValue(jobtxtfield.tag, forKey:"huqid")
        }
        
        if(jobtxtfield.text != ""){
            
            jobhistorydetails.setValue(muqid, forKey:"muqid")
            jobhistorydetails.setValue(jobhisttext, forKey:"description")
            jobhistorydetails.setValue("1", forKey:"is_active")
            jobhistorydetails.setValue("1", forKey:"createdby")
            jobhistorydetails.setValue("", forKey:"createddt")
 
            FunDrug().JobHistCU(jobhistdata:jobhistorydetails)
            
        }
        
        jobtxtfield.text = ""
        jobtxtfield.tag = 0;
        jobtxtfield.resignFirstResponder()
        
        scrJobs.contentSize = CGSize(width: 0, height: (scrJobs.subviews.count - 2)*40)
        scrJobs.isScrollEnabled = true
        self.populatejobHist()
        
        
    }
    
    @IBAction func btnLibraryClick(_ sender: UIButton) {
        
        fileNameArray .removeAllObjects()
        
        imgData.removeAllObjects()
        
        selectedCount.text = "0 Selected";
        
        counter = 0;
        
        for subview in self.scrollPic.subviews{
            subview.removeFromSuperview()
        }
        
        var posxa :Int = 10
        var posya :Int = 10
        var imgcnta :Int = 0
        
        gallery_view.isHidden = false
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                for index in 0..<allPhotos.count{
                    self.imageAssets.append((allPhotos[index]))
                    PHImageManager.default().requestImageData(for: self.imageAssets[index], options: PHImageRequestOptions(), resultHandler:
                        {
                            (imagedata, dataUTI, orientation, info) in
                            if info!.keys.contains(NSString(string: "PHImageFileURLKey"))
                            {
                                let path = info![NSString(string: "PHImageFileURLKey")] as! NSURL
                                
                                    if(imgcnta == 3){
                                        
                                        posya+=120;
                                        posxa = 10;
                                        imgcnta = 0;
                                    }
                                    
                                    
                                     let thumbnail = self.getUIImage(asset:self.imageAssets[index]) as! UIImage
                                    
                                    let imageview = UIImageView(image:thumbnail)
                                    imageview.isUserInteractionEnabled = true
                                    imageview.contentMode = UIViewContentMode.scaleAspectFit
                                    imageview.frame = CGRect(x: posxa, y: posya, width: 100, height: 100)
                                    
                                    
                                    
                                    let button = UIButton()
                                    button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                                    button.backgroundColor = UIColor.clear
                                    button.setTitle(path.path, for: .disabled)
                                    button.isUserInteractionEnabled = true
                                    button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                                    imageview.addSubview(button)
                                    
                                    self.gallery_scroll.addSubview(imageview)
                                    
                                    
                                    posxa+=120
                                    
                                    imgcnta+=1
                                }
                            })
                    }
                
                    
                    case .denied, .restricted:
                    print("Not allowed")
                    case .notDetermined:
                    print("Not determined yet")
                }
            }
        }
        
        
        
        @objc func buttonAction(sender: UIButton!) {
            print(sender.isSelected)
            
            let imageview = sender.superview as! UIImageView
            let image = imageview.image as! UIImage
            let filepath = sender.title(for: .disabled)
            
            sender.isSelected = !sender.isSelected
            
            if(sender.isSelected == true)
            {
                imageview.alpha = 0.5
                counter+=1;
                imgData .add(image)
                fileNameArray.add(filepath)
                
            }
            else
            {
                imageview.alpha = 1.0
                counter-=1;
                imgData .remove(image)
                fileNameArray.remove(filepath)
            }
            
            selectedCount.text = "\(counter) Selected"
            
            
        }
        
        
        @IBAction func btnDoneClick(_ sender: UIButton) {
            
            do{
                
                for index in 0..<imgData.count{
                
                var imagepath:String = ""
                
                var imageName:String = fileNameArray.object(at:index) as! String
                    
                imageName = (imageName as! NSString).lastPathComponent
                
                let path1:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                let documentsDirectory = String(format:"%@/edited_images/",path1.object(at: 0) as! String)
                
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
                    }
                    
                    
                    if(imageName.count>0){
                        imageName="presc.jpg"
                    }
                    imageName = String(format:"%@_%@",format .string(from: now),imageName)
                    imagepath = documentsDirectory + imageName
                    
                   
                    
                    let webdata:NSData  = commonLibrary().compressImage(image:imgData.object(at:index) as! UIImage)
                    
                    let filePathUrl = NSURL.fileURL(withPath: imagepath)
                    webdata .write(to: filePathUrl, atomically: true)
                    
                    
                    
                    let  filename = filePathUrl.lastPathComponent as! String
                    
                    
                    let fileDetails = NSMutableDictionary()
                    
                    fileDetails .setValue("", forKey:"mpuqid")
                    fileDetails .setValue(muqid, forKey:"muqid")
                    fileDetails .setValue(filePathUrl.path, forKey:"filepath")
                    fileDetails .setValue(filename, forKey:"filename")
                    fileDetails .setValue("1", forKey:"is_active")
                    fileDetails .setValue("", forKey:"createdby")
                    fileDetails .setValue("", forKey:"createddt")
                    
                FunDrug().picturesfileCu(filedetails: fileDetails)
                    
                }
                
                
                gallery_view.isHidden = true
                posx = 10;
                posy = 10;
                imgcnt = 0
                
                let insertsql  = String(format:"select id_model_picture,mpuqid,muqid,file_path,file_name,is_active,createdby,createddt,createddt from model_picture where muqid='%@' and is_active=1;",muqid)
                
                let resultset = DBManager().queryExecute(sqlQuery: insertsql)
                
                if(resultset.count > 0){
                    
                    for i in (0..<resultset.count){
                        
                        
                        filepath = "\((resultset.value(forKey:"file_path") as! NSArray).object(at:i) as! String)"
                        mpuqid = "\((resultset.value(forKey:"mpuqid") as! NSArray).object(at:i) as! String)"
                        id_model_picture = "\((resultset.value(forKey:"mpuqid") as! NSArray).object(at:i) as! String)"
                        
                        let url = URL(fileURLWithPath: filepath)
                        
                        let data = try Data(contentsOf:url)
                        
                        let image = UIImage(data:data)
                        
                        if(imgcnt == 3){
                            
                            posy += 120;
                            posx = 10;
                            imgcnt = 0;
                        }
                        
                        let imageview = UIImageView(image:image)
                        imageview.contentMode = UIViewContentMode.scaleAspectFit
                        imageview.frame = CGRect(x: posx, y: posy, width: 100, height: 100)
                        imageview.isUserInteractionEnabled = true
                        
                        
                        var delbutton = UIButton()
                        delbutton = Design().createbutton(button: delbutton, frame:CGRect(x: 0, y: 0, width: 25, height: 25), backgroundcolor:.clear, title:"")
                        delbutton.addTarget(self, action:#selector(btnPicDeleteClick), for:.touchUpInside)
                        delbutton.isUserInteractionEnabled = true
                        delbutton.setBackgroundImage(UIImage(named:"delete_icon"), for: .normal)
                        delbutton.setTitle(id_model_picture, for: .selected)
                        delbutton.setTitle(mpuqid, for: .disabled)
                        imageview .addSubview(delbutton)
                        
                        scrollPic .addSubview(imageview)
                        
                        posx+=120
                        
                        imgcnt+=1
                        
                        
                        
                    }
                    
                }
           
                
            }
            catch{
                
                
            }
        }
        
        
        
        func getUIImage(asset: PHAsset) -> UIImage? {
            
            var img: UIImage?
            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.version = .original
            options.isSynchronous = true
            manager.requestImageData(for: asset, options: options) { data, _, _, _ in
                
                if let data = data {
                    img = UIImage(data: data)
                }
            }
            return img
            
            
        }
        
        
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField==HipsTextField || textField==ShoeTextField || textField==EyeTextField || textField==HairTextField || textField==WaistTextField || textField==BustTextField){
            
            let parentView  = textField .superview as! UIView
            
            InfoScrollView.setContentOffset(CGPoint(x: 0, y: parentView.frame.origin.y - 100), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       InfoScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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
