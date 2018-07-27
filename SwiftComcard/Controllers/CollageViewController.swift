//
//  CollageViewController.swift
//  SwiftComcard
//
//  Created by Andesoft on 23/01/17.
//  Copyright © 2017 Andesoft. All rights reserved.
//

import UIKit

class CollageViewController: UIViewController {
 
    
    
    @IBOutlet weak var btnHeading: UIButton!
    
    @IBOutlet weak var sendMail: UIButton!
    
    @IBOutlet weak var templateBtn: UIButton!
    
    @IBOutlet weak var modelBtn: UIButton!
    
    
    @IBOutlet weak var previewBtn: UIButton!
    
    @IBOutlet weak var publishBtn: UIButton!
    
    @IBOutlet weak var templateBorder: UIView!
    
    @IBOutlet weak var modelBorder: UIView!
    
    
    @IBOutlet weak var previewBorder: UIView!
    
    @IBOutlet weak var publishBorder: UIView!
    
    
    @IBOutlet weak var uiScrollModel: UIScrollView!
    
    @IBOutlet weak var uiScrollPublish: UIScrollView!
    
    
    
    @IBOutlet weak var previewTable: UITableView!
    
    
    
    @IBOutlet weak var templateView: UIView!
    
    
    @IBOutlet weak var nameTextView: UIView!
    
    
    @IBOutlet weak var jobnameTextField: UITextField!
    
    
    @IBOutlet weak var jobemailTextField: UITextField!
    
    
    @IBOutlet weak var jobphoneTextField: UITextField!
    
    
    @IBOutlet weak var tempView: UIImageView!
    
    
    var HeadingTitle = ""
    var editJobid = ""
    var jobID = ""
    var tuqid = ""
    var muqid = ""
    var filepath = ""
    var is_selected = ""
    var reciverA  = Bool()
    var isclicked = Bool()
    var x:Int = 0
    var y:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {
    }
    
    @IBAction func btnSendMail(_ sender: UIButton) {
    }
    
    
    @IBAction func templateBtnClick(_ sender: UIButton) {
        
       
        
    }
    
    @IBAction func modelBtnClick(_ sender: UIButton) {
        
        
        if(self.saveTemplate()==true){
            
            self.initiateModelView()
        }
        
    }
    
    func saveTemplate() -> Bool{
        
        
        
        do{
            
            var isValid: Bool = true
            var isValid1: Bool = true
            let jobDetails = NSMutableDictionary()
            
            isValid = self.txtFieldValidate(textField:jobnameTextField) && isValid ?true:false
            isValid = self.txtFieldValidate(textField:jobemailTextField) && isValid ?true:false
            isValid = self.txtFieldValidate(textField:jobphoneTextField) && isValid ?true:false
            
            isValid1 = self.validateEmail(enteredEmail: jobemailTextField.text!)
            
            if(isValid1==false){
                
                jobemailTextField.layer.borderColor = UIColor.red.cgColor
                jobemailTextField.layer.borderWidth = 1
                
            }
            else{
                jobemailTextField.layer.borderWidth = 0
                isValid = true
            }
            
            if(isValid==true){
                
            jobDetails.setValue("", forKey:"juqid")
            jobDetails.setValue(jobnameTextField.text, forKey:"name")
            jobDetails.setValue(tuqid, forKey:"tuqid")
            jobDetails.setValue("", forKey:"order")
            jobDetails.setValue("1", forKey:"is_active")
            jobDetails.setValue("1", forKey:"createdby")
            jobDetails.setValue(commonLibrary().getDatabaseDatetime(), forKey:"createddt")
            jobDetails.setValue("1", forKey:"modifiedby")
            jobDetails.setValue(commonLibrary().getDatabaseDatetime(), forKey:"modifieddt")
            jobDetails.setValue(jobemailTextField.text, forKey:"email")
            jobDetails.setValue(jobphoneTextField.text, forKey:"phone_number")
        
            FunDrug().JobCU(modeldata: jobDetails)
                
            jobID = commonLibrary().getJobId()
            return true
            }
        }
        catch{
            
            
        }
        
        return false
        
    }
    func initiateModelView(){
        
        
        templateView.isHidden = true
        templateBorder.isHidden = true
        
        uiScrollModel.isHidden = false
        modelBorder.isHidden = false
        
        
        previewTable.isHidden = true
        previewBorder.isHidden = true
        
        
        uiScrollPublish.isHidden = true
        publishBorder.isHidden = true
        
        
        for subview in self.uiScrollModel.subviews{
            subview.removeFromSuperview()
        }
        
        let x:Int = 5;
        var y:Int = 5;
        
        let insertsql  = String(format:"select *,(select file_path || '/' || file_name from model_picture where muqid = m.muqid and is_active=1 ORDER BY createddt DESC LIMIT 1) AS file_path,(select juqid from job_model where muqid = m.muqid and juqid = '%ld' LIMIT 1 ) as is_selected from model m where((EXISTS(select juqid from job_model where muqid = m.muqid and juqid = '%ld'))OR m.is_active=1);",(jobID as NSString).integerValue,(jobID as NSString).integerValue)
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        
        
        
        if(resultset.count > 0){
            
            for i in (0..<resultset.count){
                
                muqid = "\((resultset.value(forKey:"muqid") as! NSArray).object(at:i) as! String)"
                filepath = "\((resultset.value(forKey:"file_path") as! NSArray).object(at:i) as! String)"
                var modelbtn = UIButton()
                
                modelbtn = Design().createbutton(button: modelbtn, frame:CGRect(x:x,y:y,width:Int(uiScrollModel.frame.size.width),height:140), backgroundcolor: .white, title: "")
                modelbtn.addTarget(self, action:#selector(modelClick), for:.touchUpInside)
                
                modelbtn.setTitle(muqid, for: .selected)
                
                if(filepath.count>0){
 
                    let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                    let documentsDirectory = path .object(at: 0) as! String
                    filepath = (filepath as NSString).lastPathComponent
                    let filename = documentsDirectory + "/edited_images/" + filepath
                    
                    let url = NSURL.init(fileURLWithPath: filename)
                    
                    let data  = NSData.init(contentsOf: url as URL)
                    
                    let image = UIImage.init(data:data! as Data)
                    
                    let jobimages = UIImageView.init(frame: CGRect(x: 10, y: 10, width: 120, height: 120))
                    
                    jobimages.image = image
                    
                    
                    if(is_selected != ""){
                        
                        var selectedbtn = UIButton()
                        
                        selectedbtn = Design().createbutton(button: selectedbtn, frame: CGRect(x:0,y:80,width:40,height:40), backgroundcolor: .white, title: "")
                        
                        selectedbtn.setBackgroundImage(UIImage.init(named: "add_select_icon"), for: .normal)
                        
                        
                        selectedbtn.setTitle(is_selected, for: .disabled)
                        
                        jobimages .addSubview(selectedbtn)
                        
                    }
                    
                    modelbtn .addSubview(jobimages)
                    
                    
                    
                }
               
                var modelName = UILabel()
                modelName = Design().createlabel(label: modelName, frame: CGRect(x:150,y:10,width:120,height:25), textalignment:.justified, value:"\((resultset.value(forKey:"fname") as! NSArray).object(at:i) as! String)" , backgroundcolor: .white)
                
                
                var modelHeight = UILabel()
                modelHeight = Design().createlabel(label: modelHeight, frame: CGRect(x:150,y:38,width:120,height:20), textalignment:.justified, value:"Height:" + "\((resultset.value(forKey:"height") as! NSArray).object(at:i) as! String)" , backgroundcolor: .white)
                
                var modelBust = UILabel()
                modelBust = Design().createlabel(label: modelBust, frame: CGRect(x:150,y:61,width:180,height:20), textalignment:.justified, value:"Bust:" + "\((resultset.value(forKey:"bust") as! NSArray).object(at:i) as! String)" , backgroundcolor: .white)
                
                if("\((resultset.value(forKey:"bust") as! NSArray).object(at:i) as! String)" == "Male"){
                    
                    modelBust.text = "Chest:" + "\((resultset.value(forKey:"bust") as! NSArray).object(at:i) as! String)"
                }
                
                var modelWaist = UILabel()
                modelWaist = Design().createlabel(label: modelWaist, frame: CGRect(x:150,y:84,width:180,height:20), textalignment:.justified, value:"Waist:" + "\((resultset.value(forKey:"waist") as! NSArray).object(at:i) as! String)" , backgroundcolor: .white)
                
                var modelHips = UILabel()
                modelHips = Design().createlabel(label: modelHips, frame: CGRect(x:150,y:107,width:180,height:20), textalignment:.justified, value:"Hips:" + "\((resultset.value(forKey:"hips") as! NSArray).object(at:i) as! String)" , backgroundcolor: .white)
                
                
               
                
                var border = UIView()
                border = Design().createView(view: border, frame: CGRect(x:0,y:138,width:uiScrollModel.frame.size.width - 20 ,height:2), backgoroundcolor: .lightGray)
                
                
               
                
                modelbtn .addSubview(modelName)
                modelbtn .addSubview(modelHeight)
                modelbtn .addSubview(modelBust)
                modelbtn .addSubview(modelWaist)
                modelbtn .addSubview(modelHips)
                modelbtn .addSubview(border)
                
                
                uiScrollModel .addSubview(modelbtn)
                
                y += 140;
               
            
        }
        
        
        }
        
        
    }
    @objc func modelClick(_sender:UIButton) {
        
        commonLibrary().setModelUniqueId(ModelUniqueId: _sender.title(for: .selected)!)
        
        is_selected = _sender.title(for: .disabled)!
        
        if(tuqid == "1"){
            
            self.performSegue(withIdentifier:"pushTemplate", sender: self)

        }
        else if (tuqid == "2"){
            
            self.performSegue(withIdentifier:"pushTemplate2", sender: self)
        }
        else{
            
            self.performSegue(withIdentifier:"pushTemplate3", sender: self)

        }
        
    }
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    func txtFieldValidate(textField:UITextField) -> Bool{
        
        if(textField.text?.characters.count == 0){
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1
            return false
            
        }
        
        return true
    }
    
    
    @IBAction func previewBtnClick(_ sender: UIButton) {
        
        
        
    }
    @IBAction func publishBtnClick(_ sender: UIButton) {
        
        templateView.isHidden = true
        templateBorder.isHidden = true
        
        
        modelBorder.isHidden = true
        uiScrollModel.isHidden = true
        
        
        previewTable.isHidden = true
        previewBorder.isHidden = true
        
        
        publishBorder.isHidden = false
        uiScrollPublish.isHidden = false
        
        x = 0
        y = 0
        
        
        do{
            for subview in self.uiScrollPublish.subviews{
                subview.removeFromSuperview()
            }
            
            uiScrollPublish.contentSize = CGSize(width: 320, height: 600)
            
            
            
            let insertsql = String(format:"select fname, m.muqid, height,gender, bust, waist, hips, shoe, eye, hair, file_path from model m inner join job_model jm on m.muqid = jm.muqid where juqid = '%ld';",(jobID as NSString).integerValue)
            
            
            
            let resultSet:NSMutableArray = DBManager().queryExecute(sqlQuery: insertsql)
            
            if(resultSet.count > 0){
                
                
                var mainView = UIView()
                
                
                mainView = Design().createView(view: mainView, frame: CGRect(x:x,y:y,width:Int(uiScrollPublish.frame.size.width),height:300), backgoroundcolor: UIColor(red: 234, green: 233, blue: 231, alpha: 1.0));
                
                
                mainView.tag = 1011;
                
                
                
                var filename = "\((resultSet.value(forKey:"file_path") as! NSArray).object(at:0) as! String)"
                
                filename = (filename as NSString).lastPathComponent
                
                let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                let documentsDirectory = path .object(at: 0) as! String
                
                let filepath1 = documentsDirectory + "/edited_images/" + filename
                
                let url = URL(fileURLWithPath: filepath1)
                
                let data = try Data(contentsOf:url)
                
                let image = UIImage(data:data)
                
                let imageview = UIImageView(image:image)
                imageview.frame = CGRect(x: 10, y: 10, width: uiScrollPublish.frame.size.width - 20 , height: (uiScrollPublish.frame.size.width - 20) * 0.70 )
                
                uiScrollPublish.addSubview(imageview)
                
            }
        }
        catch{
            
            
        }
        
        
        
    }
    
    
    @IBAction func btn3layerClick(_ sender: UIButton) {
        
        commonLibrary().setTemplateId(TemplateId:"1")
        tempView.image = UIImage.init(named: "crop2_big.png")
        tuqid = "1"
    }
    
    
    @IBAction func btn5layerClick(_ sender: UIButton) {
    
        commonLibrary().setTemplateId(TemplateId:"2")
        tempView.image = UIImage.init(named: "layer2")
        tuqid = "2"

    }
    
    
    
    @IBAction func btn5layer2Click(_ sender: UIButton) {
        
        commonLibrary().setTemplateId(TemplateId:"3")
        tempView.image = UIImage.init(named: "layer3")
        tuqid = "3"

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
