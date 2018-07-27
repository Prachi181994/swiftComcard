//
//  FunDrug.swift
//  SwiftComcard
//
//  Created by Andesoft on 01/03/18.
//  Copyright © 2018 Andesoft. All rights reserved.
//

import UIKit

class FunDrug: DBManager {

    
    var model_id:String = "",
    model_uqname:String = "",
    insertsql:String = "",
    muqid:String = "",
    jobhist_id:String="",
    job_huqid:String = "",
    id_model_pic:String = "",
    id_model_picuqid:String = "",
    id_job_pic:String = "" ,
    jpuqid:String="",
    
    juqid:String = "",
    id_job_model:String = "",
    temp_id:String = "",
    tuqid:String = "",
    id_job:String = "",
    id_publish_job:String = "",
    publish_uqid:String = "",
    id_publish:String = "",
    puqid:String = "",
    id_model_card:String = "",
    cuqid:String = ""
    
    var cm = commonLibrary()
    func modelCu(modeldata:NSMutableDictionary) -> Bool {
        
        do{
            print(modeldata.value(forKey:"id_model" ) as? String ?? "hhelloeohhfe")
            
            if let value = modeldata.value(forKey:"id_model" ) as? String{
                
                model_id = value;
                model_uqname =  modeldata.value(forKey:"muqid" ) as! String
                
                insertsql = String(format:"update model set fname='%@',lname='%@',height='%@', bust='%@',waist='%@',hips='%@',shoe='%@',eye='%@',hair='%@',is_active='%@',gender='%@',chest='%@'where id_model='%@' and muqid ='%@';",modeldata.value(forKey: "fname") as! String,modeldata.value(forKey: "lname") as! String,modeldata.value(forKey: "height") as! String,modeldata.value(forKey: "bust")as! String,modeldata.value(forKey: "waist")as! String,modeldata.value(forKey: "hips")as! String,modeldata.value(forKey: "shoe")as! String,modeldata.value(forKey: "eye")as! String,modeldata.value(forKey: "hair")as! String,modeldata.value(forKey: "is_active")as! String,modeldata.value(forKey: "gender")as! String,modeldata.value(forKey: "chest")as! String,model_id,model_uqname)
                
                
                if(super.saveData(insertSQL: insertsql) == true){
                    
                    return true
                }
            }
            else{
                
                model_id = ""
                muqid = ""
                model_uqname = ""
                
                insertsql = String(format:"insert into model (muqid,fname,height,bust,waist,hips,shoe,eye,hair,is_active,createdby,createddt,modifiedby,modifieddt,gender,chest) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model_uqname,modeldata.value(forKey: "fname") as! String,modeldata.value(forKey: "height") as! String,modeldata.value(forKey: "bust")as! String,modeldata.value(forKey: "waist")as! String,modeldata.value(forKey: "hips")as! String,modeldata.value(forKey: "shoe")as! String,modeldata.value(forKey: "eye")as! String,modeldata.value(forKey: "hair")as! String,modeldata.value(forKey: "is_active")as! String,modeldata.value(forKey: "createdby")as! String,modeldata.value(forKey: "createddt")as! String,modeldata.value(forKey: "modifiedby")as! String,modeldata.value(forKey: "modifieddt")as! String,modeldata.value(forKey: "gender")as! String,modeldata.value(forKey: "chest")as! String)
                
                print(insertsql)
                if(super.saveData(insertSQL: insertsql) == true){
                    
                    insertsql = String(format:"select MAX(id_model),muqid from model;")
                    
                    let resultset = super .queryExecute(sqlQuery: insertsql)
                    
                    print(type(of: resultset))
                    
                    if(resultset.count>0){
                        
                        model_id  = "\((resultset.value(forKey:"MAX(id_model)") as! NSArray).object(at:0) as! Int)"
                        
                        
                        // muqid = "\((resultset.value(forKey:"muqid") as! NSArray).object(at:0) as! Int)"
                        
                        print(model_id)
                        print(muqid)
                        commonLibrary().setModelID(idmodel: model_id)
                        
                        
                        
                        
                    }
                    
                    insertsql = String(format:"update model set muqid='%@'where id_model='%@';",commonLibrary().getModelID(),commonLibrary().getModelID())
                    
                    
                    if(super.saveData(insertSQL: insertsql)){
                        
                        return true
                    }
                    
                }
            }
            
        return false
    }
        catch{
            
            
        }
    }
    
    func modelDelete(modelData:NSMutableDictionary) ->Bool{
        
        
        insertsql = String(format:"update model set is_active = '%@' where id_model='%@';",modelData.value(forKey:"is_active" ) as! String,modelData.value(forKey:"muqid" ) as! String)
        
        if(super.saveData(insertSQL: insertsql)){
            
            return true
        }
        
        return false
        
    }
    func picturesfileCu(filedetails:NSMutableDictionary) -> Bool{
        
        
        if let value = filedetails.value(forKey:"id_model_picture" ) as? String{
            
            id_model_pic = value
           
            id_model_picuqid = id_model_pic
            
            
            insertsql = String(format:"update model_picture set is_active='%@' where mpuqid ='%@';",filedetails.value(forKey:"is_active" ) as! String,id_model_picuqid)
            
            if(super.saveData(insertSQL: insertsql)){
                
                return true
            }
        }
        else{
            
            id_model_picuqid = ""
            
            
            insertsql = String(format:"insert into model_picture (mpuqid,muqid,file_path,file_name,is_active,createdby,createddt) values('%@','%@','%@','%@','%@','%@','%@')",id_model_picuqid,filedetails .value(forKey:"muqid") as! String,filedetails .value(forKey:"filepath") as! String,filedetails .value(forKey:"filename") as! String,filedetails .value(forKey:"is_active") as! String,filedetails .value(forKey:"createdby") as! String,filedetails .value(forKey:"createddt") as! String)
            
            
            
            if(super.saveData(insertSQL: insertsql) == true){
                
                insertsql = String(format:"select MAX(id_model_picture) from model_picture;")
                
                let resultset = super .queryExecute(sqlQuery: insertsql)
                
                print(type(of: resultset))
                
                if(resultset.count>0){
                
                    id_model_pic = "\((resultset.value(forKey:"MAX(id_model_picture)") as! NSArray).object(at:0) as! Int)"
                    
                    
                }
                
                insertsql = String(format:"update model_picture set mpuqid='%@' where id_model_picture ='%@';",id_model_pic,id_model_pic)
                
                if(super.saveData(insertSQL: insertsql) == true){
                    
                    return true;
                }
                
            }
            
            
        }
        
        return false;
    }

    func JobHistCU(jobhistdata:NSMutableDictionary) -> Bool{
        
        
        
        job_huqid = jobhistdata.value(forKey:"huqid" ) as! String
        
    
        if(job_huqid.count>0){
            
//            jobhist_id = jobhistdata.value(forKey:"id_history" ) as! String
            
            insertsql = String(format:"update model_job_history set description='%@',is_active='%@' where huqid ='%@';",jobhistdata .value(forKey:"description") as! String,jobhistdata .value(forKey:"is_active") as! String ,job_huqid)
            
            if(super.saveData(insertSQL: insertsql)){
                
                return true
            }
            
        }
        else{
            
            insertsql = String(format:"insert into model_job_history (huqid,muqid,description,is_active,createdby,createddt) values ('%@','%@','%@','%@','%@','%@')",job_huqid,jobhistdata .value(forKey:"muqid") as! String,jobhistdata .value(forKey:"description") as! String,jobhistdata .value(forKey:"is_active") as! String,jobhistdata .value(forKey:"createdby") as! String,jobhistdata .value(forKey:"createddt") as! String)
            
            
            
            if(super.saveData(insertSQL: insertsql) == true){
                
                insertsql = String(format:"select MAX(id_history) from model_job_history;")
                
                let resultset:NSMutableArray = super .queryExecute(sqlQuery: insertsql)
                
                if(resultset.count>0){
                    
                    jobhist_id = "\((resultset.value(forKey:"MAX(id_history)") as! NSArray).object(at:0) as! Int)"
                    
                }
                print(jobhist_id)
            
               insertsql = String(format:"update model_job_history set huqid='%@' where id_history ='%@';",jobhist_id,jobhist_id)
            
                
                print(insertsql)
                if(super.saveData(insertSQL: insertsql) == true){
                    
                    return true;
                }
            
        }
        
    }
        return false;
    }
    func jobDelete(jobData:NSMutableDictionary) ->Bool{
        
        
        insertsql = String(format:"update job set is_active = '%@' where id_job='%@';",jobData.value(forKey:"is_active" ) as! String,jobData.value(forKey:"juqid" ) as! String)
        
        if(super.saveData(insertSQL: insertsql)){
            
            return true
        }
        
        return false
        
    }
    func CardFiles(filedetails:NSMutableDictionary) -> Bool{
        
        if(id_model_card.count>0){
            
            id_model_card = filedetails.value(forKey:"id_model_card" ) as! String
            cuqid = filedetails.value(forKey:"cuqid") as! String
            
            
            if((id_model_card .contains("'")) && (cuqid .contains("'"))){
                
                id_model_card = id_model_card.replacingOccurrences(of: "'", with: "''")
                cuqid = cuqid.replacingOccurrences(of: "'", with: "''")
            }
            
            
            
            
            insertsql = String(format:"update model_card set is_active='%@' where cuqid ='%@';",filedetails.value(forKey: "is_active") as! String,cuqid)
            
            
            if(super.saveData(insertSQL: insertsql) == true){
                
                return true
            }
        }
        else{
            
            id_model_card = ""
            cuqid = ""
           
            
            insertsql = String(format:"insert into model_card (cuqid,muqid,file_path,file_name,is_active,createdby,createddt) values('%@','%@','%@','%@','%@','%@','%@')",cuqid,filedetails.value(forKey: "muqid") as! String,filedetails.value(forKey: "file_path") as! String,filedetails.value(forKey: "file_name")as! String,filedetails.value(forKey: "is_active")as! String,filedetails.value(forKey: "createdby")as! String,filedetails.value(forKey: "createddt")as! String)
            
            print(insertsql)
            if(super.saveData(insertSQL: insertsql) == true){
                
                insertsql = String(format:"select MAX(id_model_card) from model_card;")
                
                let resultset = super .queryExecute(sqlQuery: insertsql)
                
                print(type(of: resultset))
                
                if(resultset.count>0){
                    
                    id_model_card  = "\((resultset.value(forKey:"MAX(id_model_card)") as! NSArray).object(at:0) as! Int)"
                    
                    
                    // muqid = "\((resultset.value(forKey:"muqid") as! NSArray).object(at:0) as! Int)"
                    
                    print(model_id)
                    print(muqid)
                    commonLibrary().setModelID(idmodel: model_id)
                    
                    
                    
                    
                }
                
                insertsql = String(format:"update model_card set cuqid='%@'where id_model_card='%@'",id_model_card,id_model_card)
                
                
                if(super.saveData(insertSQL: insertsql)){
                    
                    return true
                }
                
            }
        }
        
        
        
        
        
        return false
    }
    
    func PhotFilesCU(filedetails:NSMutableDictionary) -> Bool{
        
        
        if let value = filedetails.value(forKey:"id_job_model" ) as? String{
            
            id_job_model = value
            
            juqid = id_job_model
            
            
            insertsql = String(format:"update job_model set file_path='%@' where muqid ='%@' and juqid ='%@';",filedetails.value(forKey:"filepath" ) as! String,filedetails.value(forKey:"muqid" ) as! String,juqid)
            
            if(super.saveData(insertSQL: insertsql)){
                
                return true
            }
        }
        else{
            
            
            var order :Int = 0
            id_model_picuqid = ""
            
             insertsql = String(format:"select MAX([order])  from job_model where juqid=%@;",filedetails.value(forKey:"juqid" ) as! String)
            
            
            let resultset = super.queryExecute(sqlQuery: insertsql)
            
            if(resultset.count>0){
                
               var order = (resultset.value(forKey:"MAX([order])") as! NSArray).object(at:0) as! Int
               order+=1
            }
            
            insertsql = String(format:"insert into job_model (juqid,muqid,is_active,createdby,createddt,file_path,[order]) values('%@','%@','%@','%@','%@','%@','%d')",filedetails .value(forKey:"juqid") as! String,filedetails .value(forKey:"muqid") as! String,filedetails .value(forKey:"is_active") as! String,filedetails .value(forKey:"createdby") as! String,filedetails .value(forKey:"createddt") as! String,filedetails .value(forKey:"filepath") as! String,order)
            
            
            
            if(super.saveData(insertSQL: insertsql) == true){
                
                insertsql = String(format:"select MAX(id_job_model) from job_model;")
                
                let resultset = super .queryExecute(sqlQuery: insertsql)
                
                print(type(of: resultset))
                
                if(resultset.count>0){
                    
                    id_job_model = "\((resultset.value(forKey:"MAX(id_job_model)") as! NSArray).object(at:0) as! Int)"
                    
                    
                }
                
               
                
            }
            
            
        }
        
        return false;
    }

    func DragPicturesFilesCU(filedetails:NSMutableDictionary) -> Bool{
        
       
        
        id_job_pic = ""
        jpuqid = id_job_pic
        
        
        insertsql = String(format:"insert into job_pic (jpuqid,juqid,mpuqid,file_path)values('%@','%@','%@','%@')",jpuqid,filedetails.value(forKey:"juqid" ) as! String,filedetails.value(forKey:"mpuqid" ) as! String,filedetails.value(forKey:"file_path" ) as! String)
        
       if(super.saveData(insertSQL: insertsql) == true){
        
        
        insertsql = String(format:"select MAX(id_job_pic) from job_pic;")
        
        
        let resultset = super .queryExecute(sqlQuery: insertsql)
        
        if(resultset.count>0){
            
           
            
            id_job_pic = "\((resultset.value(forKey:"MAX(id_job_pic)") as! NSArray).object(at:0) as! Int)"
            
            
            
        }
        
        insertsql = String(format:"update job_pic set jpuqid='%@' where id_job_pic ='%@';",id_job_pic,id_job_pic)
        
        if(super.saveData(insertSQL: insertsql) == true){
            
            return true;
        }
        }
        return false;
    }
    
     func UpdateOrder(filedetails:NSMutableDictionary) -> Bool{
        
        juqid = filedetails.value(forKey:"juqid" ) as! String

        let actionvalue :String = filedetails.value(forKey: "action") as! String
        var insertsql2:String = ""
        if(juqid.count>0){
        if(actionvalue.count>0){
            
            insertsql = String(format:"update job_model set [order]=[order]-1  where juqid ='%@' and muqid=%@;",juqid,filedetails.value(forKey: "muqid") as! String)
            
         insertsql2 = String(format:"update job_model set [order]=[order]+1  where juqid ='%@' and [order] = %d and muqid!=%@; ",juqid,filedetails.value(forKey: "muqid") as! Int - 1,filedetails.value(forKey: "muqid") as! String)
        }
        else{
            insertsql = String(format:"update job_model set [order]=[order]+1  where juqid ='%@' and muqid=%@;",juqid,filedetails.value(forKey: "muqid") as! String)
            
           insertsql2 = String(format:"update job_model set [order]=[order]-1  where juqid ='%@' and [order] = %d and muqid!=%@; ",juqid,filedetails.value(forKey: "muqid") as! Int - 1,filedetails.value(forKey: "muqid") as! String)
        }
        
        if(super.saveData(insertSQL: insertsql) == true){
            super.saveData(insertSQL: insertsql2);
            return true;
        }
    }
        return true
    }
    
    func getMaxId(tablename:String,fieldName:String) -> String {
        
        var max_id:String = "0";
        
        if(super.saveData(insertSQL: insertsql) == true){
            insertsql = String(format:"select %@ from %@  order by %@ desc limit 1",fieldName,tablename,fieldName)
            let resultset:NSMutableArray = [super .queryExecute(sqlQuery: insertsql)]
            
            if(resultset.count>0){
                
                let value :NSMutableDictionary = resultset[0] as! NSMutableDictionary
                
                max_id = value .value(forKey:fieldName) as! String
                
                
            }
    }
        return max_id
    }
    
    func TemplateDetails(TemplateData:NSMutableDictionary) -> Bool{
        
        temp_id = TemplateData.value(forKey:"id_template" ) as! String
        tuqid = TemplateData.value(forKey:"tuqid") as! String
        
        if((temp_id .contains("'")) && (tuqid .contains("'"))){
            
            temp_id = model_id.replacingOccurrences(of: "'", with: "''")
            tuqid = model_uqname.replacingOccurrences(of: "'", with: "''")
        }
        
        insertsql = String(format:"insert into template (tuqid,name,id_model,is_active,createdby,createddt) values ('%@','%@','%@','%@','%@','%@')",tuqid,TemplateData.value(forKey: "name") as! String,TemplateData.value(forKey: "id_model") as! String,TemplateData.value(forKey: "is_active") as! String,TemplateData.value(forKey: "createdby") as! String,TemplateData.value(forKey: "createddt") as! String)
        
        
        if(super.saveData(insertSQL: insertsql) == true){
            insertsql = String(format:"select MAX(id_template) from template;")
            let resultset:NSMutableArray = [super .queryExecute(sqlQuery: insertsql)]
            
            if(resultset.count>0){
                
                let value :NSMutableDictionary = resultset[0] as! NSMutableDictionary
                
                temp_id = value .value(forKey:"MAX(id_template)") as! String
                
                commonLibrary().setTemplateId(TemplateId:temp_id)
                
            }
            
            insertsql = String(format:"update template set tuqid='%@'where id_template='%@';",temp_id,temp_id)
            
            if(super.saveData(insertSQL: insertsql) == true){
                
                return true;
            }
        }
        return false;
    }
    
    func JobCU(modeldata:NSMutableDictionary)->Bool{
        
        
        if let value = modeldata.value(forKey: "id_job") as? String{
            
            id_job = value
            juqid = modeldata.value(forKey:"juqid" ) as! String
            insertsql = String(format:"update job set name='%@',modifiedby='%@',modifieddt='%@',email='%@',phone_number='%@' where juqid= %@ ",modeldata.value(forKey: "name") as! String,modeldata.value(forKey: "modifiedby") as! String,modeldata.value(forKey: "modifieddt")as! String,modeldata.value(forKey: "email")as! String,modeldata.value(forKey: "phone_number")as! String,juqid)
            
            commonLibrary().setJobId(JobId: juqid)
            if(super.saveData(insertSQL: insertsql) == true){
                
                return true
            }
        }
        else{
            
            id_job = ""
            juqid = ""
        
            insertsql = String(format:"insert into job  (juqid,name,tuqid,is_active,createdby,createddt,modifiedby,modifieddt,email,phone_number) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",juqid,modeldata.value(forKey: "name") as! String,modeldata.value(forKey: "tuqid") as! String,modeldata.value(forKey: "is_active")as! String,modeldata.value(forKey: "createdby")as! String,modeldata.value(forKey: "createddt")as! String,modeldata.value(forKey: "modifiedby")as! String,modeldata.value(forKey: "modifieddt")as! String,modeldata.value(forKey: "email")as! String,modeldata.value(forKey: "phone_number")as! String)
            
            
            
            if(super.saveData(insertSQL: insertsql) == true){
                
                insertsql = String(format:"select MAX(id_job) from job;")
                
                let resultset = super .queryExecute(sqlQuery: insertsql)
                
                if(resultset.count>0){
                    
                   
                    id_job = "\((resultset.value(forKey:"MAX(id_job)") as! NSArray).object(at:0) as! Int)"

                    
                    commonLibrary().setJobId(JobId:id_job)
                    
                    
                    
                    
                }
                
                insertsql = String(format:"update job set juqid='%@'where id_job='%@';",id_job,id_job)
                
                
                if(super.saveData(insertSQL: insertsql)){
                    
                    return true
                }
                
            }
        }
        
        
        return false
    }
    
    func PublishJOBCU(modelData:NSMutableDictionary)->Bool{
        
        
        id_publish_job = modelData.value(forKey:"id_publish_job" ) as! String
        publish_uqid = modelData.value(forKey:"puqid") as! String
        
        if((id_publish_job .contains("'")) && (publish_uqid .contains("'"))){
            
            id_publish_job = id_publish_job.replacingOccurrences(of: "'", with: "''")
            publish_uqid = publish_uqid.replacingOccurrences(of: "'", with: "''")
        }
        
        insertsql = String(format:"insert into publish_job (puqid,juqid,createdby,createddt,is_active,modifiedby,modifieddt) values ('%@','%@','%@','%@','%@','%@','%@')",publish_uqid,modelData.value(forKey: "juqid") as! String,modelData.value(forKey: "createdby")as! String,modelData.value(forKey: "createddt")as! String,modelData.value(forKey: "is_active")as! String,modelData.value(forKey: "modifiedby")as! String,modelData.value(forKey: "modifieddt")as! String)
        
        
        
        if(super.saveData(insertSQL: insertsql) == true){
            insertsql = String(format:"select MAX(id_publish_job) from publish_job;")
            
            let resultset:NSMutableArray = [super .queryExecute(sqlQuery: insertsql)]
            
            if(resultset.count>0){
                
                let value :NSMutableDictionary = resultset[0] as! NSMutableDictionary
                
                id_publish_job = value .value(forKey:"MAX(id_publish_job)") as! String
            }
            insertsql = String(format:"update publish_job set puqid='%@'where id_publish_job='%@';",id_publish_job,id_publish_job)
            
            
            if(super.saveData(insertSQL: insertsql)){
                
                return true
            }
        }
            return false
        }
  
    func PublishCU(modelData:NSMutableDictionary)->Bool{
        
        
        id_publish = modelData.value(forKey:"id_publish" ) as! String
        puqid = modelData.value(forKey:"puqid") as! String
        
        if((id_publish .contains("'")) && (puqid .contains("'"))){
            
            id_publish = id_publish.replacingOccurrences(of: "'", with: "''")
            puqid = puqid.replacingOccurrences(of: "'", with: "''")
        }
        
        insertsql = String(format:"insert into publish (puqid,is_active,createdby,createddt,file_path) values ('%@','%@','%@','%@','%@')",puqid,modelData.value(forKey: "is_active") as! String,modelData.value(forKey: "createdby")as! String,modelData.value(forKey: "createddt")as! String,modelData.value(forKey: "file_path")as! String)
        
        
        
        if(super.saveData(insertSQL: insertsql) == true){
            
            insertsql = String(format:"select MAX(id_publish) from publish;")
            
            let resultset:NSMutableArray = [super .queryExecute(sqlQuery: insertsql)]
            
            if(resultset.count>0){
                
                let value :NSMutableDictionary = resultset[0] as! NSMutableDictionary
                
                id_publish = value .value(forKey:"MAX(id_publish)") as! String
            }
            insertsql = String(format:"update publish set puqid='%@'where id_publish='%@';",id_publish,id_publish)
            
            
            if(super.saveData(insertSQL: insertsql)){
                
                return true
            }
        }
        return false
    }
    
}

