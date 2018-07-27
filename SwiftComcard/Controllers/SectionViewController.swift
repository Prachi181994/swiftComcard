//
//  SectionViewController.swift
//  SwiftComcard
//
//  Created by Andesoft on 23/01/17.
//  Copyright © 2017 Andesoft. All rights reserved.
//

import UIKit


class SectionViewController: UIViewController {

    var muqid:String = "",
    id_model:String = "",
    id_job:String = "",
    juqid:String = ""
    
    
    var clicked : Bool = true
    
    
    var dbm:DBManager = DBManager()
    
    @IBOutlet weak var btnAddModel: UIButton!
    @IBOutlet weak var btnAddJob: UIButton!
    @IBOutlet weak var job_border: UIView!
    @IBOutlet weak var model_directory_border: UIView!
    
    @IBOutlet weak var scrollJob: UIScrollView!
    
    @IBOutlet weak var scrollModel: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func  defaultload(){
        
        
        btnAddModel.isHidden = false
        btnAddJob.isHidden = true
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
 
        super.viewDidLoad()
        if(clicked){
            self.populateModelView()
            clicked = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateModelView(){
        
       
        
        for subview in self.scrollModel.subviews{
            subview.removeFromSuperview()
        }
        
        let x:Int = 10;
        var y:Int = 10;
        
        let insertsql  = String(format:"select *,(select file_path || '/' file_name from model_picture where muqid = m.muqid and is_active = 1 ORDER BY createddt DESC LIMIT 1) AS file_path from model m where m.is_active = 1;")
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        
        
        
        if(resultset.count > 0){
            
            for i in (0..<resultset.count){
                
                
                var modelView = UIView()
                
                modelView = Design().createView(view:modelView , frame: CGRect(x:x,y:y,width:Int(scrollModel.frame.size.width - 20) ,height:140), backgoroundcolor: .white)
                
                let id_model:String = "\((resultset.value(forKey:"id_model") as! NSArray).object(at:i) as! Int)"
                
                modelView.tag = (id_model as NSString).integerValue
                
                var filepath = "\((resultset.value(forKey:"file_path") as! NSArray).object(at:i))" 
                
            
                if(filepath.count>0){
                    do{
                    let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                    let documentsDirectory = path .object(at: 0) as! String
                    
                    filepath = documentsDirectory + "/edited_images/" + (filepath as NSString).lastPathComponent
                    
                    let url = URL(fileURLWithPath: filepath)
                    
                    let data = try Data(contentsOf:url)
                    
                    let image = UIImage(data:data)
                    
                    
                    let modelImg = UIImageView(image:image)
                    modelImg.contentMode = UIViewContentMode.scaleAspectFit
                    modelImg.frame = CGRect(x: 10 , y: 10, width: 120, height: 120)
                    modelView .addSubview(modelImg)
                        
                    }
                   
                    catch{
                        
                        
                    }
                    
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
                
                
                var deletebtn = UIButton()
                deletebtn = Design().createbutton(button: deletebtn, frame: CGRect(x:280,y:50,width:40,height:40), backgroundcolor: .clear, title:"")
                deletebtn.addTarget(self, action:#selector(modelDeleteClick), for:.touchUpInside)

                deletebtn.setImage(UIImage.init(named:"delete_icon"), for: .normal)
                
                deletebtn.setTitle("\((resultset.value(forKey:"muqid") as! NSArray).object(at:i) as! String)", for: .disabled)
                
                var border = UIView()
                border = Design().createView(view: border, frame: CGRect(x:0,y:138,width:scrollModel.frame.size.width - 20 ,height:2), backgoroundcolor: .lightGray)
                
                
                let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.gesturemodelClick))
                modelView.addGestureRecognizer(gesture)
                
                
                modelView .addSubview(modelName)
                modelView .addSubview(modelHeight)
                modelView .addSubview(modelBust)
                modelView .addSubview(modelWaist)
                modelView .addSubview(modelHips)
                modelView .addSubview(deletebtn)
                modelView .addSubview(border)
                
                
                scrollModel .addSubview(modelView)
                
                y += 140;
                
            }
              scrollModel.contentSize = CGSize(width: 0, height: 140*resultset.count)
            
        }
        
    }
    
    @objc func modelDeleteClick(_sender:UIButton) {
        
        muqid = _sender.title(for: .disabled)!
        var deletemodelDetails = NSMutableDictionary()
        deletemodelDetails.setValue(muqid, forKey:"muqid")
        deletemodelDetails.setValue("0", forKey:"is_active")
        FunDrug().modelDelete(modelData: deletemodelDetails)
        self.populateModelView()
        
        
    }
    
    
    @objc func gesturemodelClick(sender : UITapGestureRecognizer) {
        
        let view = sender.view
        id_model = "\(sender.view?.tag ?? 0)"
        self.performSegue(withIdentifier:"edit_model", sender: self)
        
    }
    
    @IBAction func btnModelClick(_ sender: UIButton) {
        
        
        btnAddJob.isHidden = true
        btnAddModel.isHidden = false
        model_directory_border.isHidden = false
        job_border.isHidden = true
        self.populateModelView()
        scrollJob.isHidden = true
        scrollModel.isHidden = false
    }
    
    
    @IBAction func btnJobsClick(_ sender: UIButton) {
        
        btnAddModel.isHidden = true
        btnAddJob.isHidden = false
        model_directory_border.isHidden = true
        job_border.isHidden = false
        scrollJob.isHidden = false
        scrollModel.isHidden = true
        self.popjobView()
    }
    
    func popjobView(){
        
        
        for subview in self.scrollJob.subviews{
            subview.removeFromSuperview()
        }
        
        let x:Int = 10;
        var y:Int = 10;
        
        let insertsql  = String(format:"select *, (select file_path from job_model where juqid = j.juqid LIMIT 1) AS file_path,(select fname from model m inner join model_picture mp on m.muqid = mp.muqid inner join job_pic jp on mp.mpuqid = jp.mpuqid where juqid = j.juqid LIMIT 1) AS model_name from job j where j.is_active =1;")
        
        let resultset = DBManager().queryExecute(sqlQuery: insertsql)
        
        
        
        if(resultset.count > 0){
            
            for i in (0..<resultset.count){
                
                
                var jobView = UIView()
                
                jobView = Design().createView(view:jobView , frame: CGRect(x:x,y:y,width:Int(scrollJob.frame.size.width - 20) ,height:140), backgoroundcolor: .white)
                
                juqid = "\((resultset.value(forKey:"juqid") as! NSArray).object(at:i))"
                
                jobView.tag = (juqid as NSString).integerValue
                
                var filepath = "\((resultset.value(forKey:"file_path") as! NSArray).object(at:i))"
                
                
                if(filepath.count>0){
                    do{
                        let path:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                        let documentsDirectory = path .object(at: 0) as! String
                        
                        filepath = documentsDirectory + "/edited_images/" + (filepath as NSString).lastPathComponent
                        
                        let url = URL(fileURLWithPath: filepath)
                        
                        let data = try Data(contentsOf:url)
                        
                        let image = UIImage(data:data)
                        
                        
                        let jobImg = UIImageView(image:image)
                        jobImg.contentMode = UIViewContentMode.scaleAspectFit
                        jobImg.frame = CGRect(x: scrollJob.frame.size.width-160 , y: 10, width: 120, height: 80)
                        jobView .addSubview(jobImg)
                        
                    }
                        
                    catch{
                        
                        
                    }
                    
                }
                
                
                var jobName = UILabel()
                jobName = Design().createlabel(label: jobName, frame: CGRect(x:20,y:10,width:120,height:25), textalignment:.justified, value:"\((resultset.value(forKey:"name") as! NSArray).object(at:i) as! String)" , backgroundcolor: .white)
                
                
                
                
                var modelName = UILabel()
                
                let modelname = "\((resultset.value(forKey:"model_name") as! NSArray).object(at:i) as? String)"
                
                
                modelName = Design().createlabel(label: modelName, frame: CGRect(x:20,y:40,width:120,height:20), textalignment:.justified, value:modelname  , backgroundcolor: .white)
                
                
                
                var jobDate = UILabel()
                jobDate = Design().createlabel(label: jobDate, frame: CGRect(x:20,y:65,width:180,height:20), textalignment:.justified, value:"\((resultset.value(forKey:"createddt") as! NSArray).object(at:i) as! String)"  , backgroundcolor: .white)
                
                
                
                
                
                var deletebtn = UIButton()
                deletebtn = Design().createbutton(button: deletebtn, frame: CGRect(x:scrollJob.frame.size.width-45,y:40,width:30,height:30), backgroundcolor: .clear, title:"")
                deletebtn.addTarget(self, action:#selector(jobDeleteClick), for:.touchUpInside)
                
                deletebtn.setImage(UIImage.init(named:"delete_icon"), for: .normal)
                
                deletebtn.setTitle("\((resultset.value(forKey:"juqid") as! NSArray).object(at:i) as! String)", for: .disabled)
                
                
                
                var border = UIView()
                border = Design().createView(view: border, frame: CGRect(x:0,y:138,width:scrollModel.frame.size.width - 20 ,height:2), backgoroundcolor: .lightGray)
                
                
                let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.gesturemodelClick))
                jobView.addGestureRecognizer(gesture)
                
                
                jobView .addSubview(jobName)
                jobView .addSubview(modelName)
                jobView .addSubview(jobDate)
                jobView .addSubview(deletebtn)
                jobView .addSubview(border)
                
                
                scrollJob .addSubview(jobView)
                
                y += 140;
                
            }
            scrollJob.contentSize = CGSize(width: 0, height: 140*resultset.count)
            
        }
        
        
    }
    
    @IBAction func BtnAddJobClick(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "add_job", sender: self)
    }

    
   
    @objc func jobDeleteClick(sender:UIButton){
        
        juqid = sender.title(for: .disabled)!
        
        let jobdeletedetails = NSMutableDictionary()
        
        jobdeletedetails .setValue(juqid, forKeyPath:"juqid")
        jobdeletedetails .setValue("0", forKeyPath:"is_active")
        
        
        FunDrug().jobDelete(jobData: jobdeletedetails)
        
        
        self.popjobView()
        
        
        
        
    }
    
    @objc func gesturjobClick(sender : UITapGestureRecognizer) {
        
        let view = sender.view
        id_job = "\(sender.view!.tag ?? 0)"
        self.performSegue(withIdentifier:"add_job", sender: self)
        
    }
   
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "edit_model") {
            
            let editmodel : AddModelViewController = segue.destination as! AddModelViewController
            editmodel.reciverA = true
            editmodel.reciever_id = id_model
            editmodel.HeadingTitle = "EDIT MODEL"
            
            
        }
        if (segue.identifier == "add_job") {
            
            let collagview : CollageViewController = segue.destination as! CollageViewController
            collagview.reciverA  = false
            collagview.isclicked = true
            
            
//            if(id_job>0){
//                exist.editJobid = id_job;
//            }
            
        }
    }
    

}
