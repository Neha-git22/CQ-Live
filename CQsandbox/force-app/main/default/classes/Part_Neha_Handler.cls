public class Part_Neha_Handler {
    
    public static void HandleCase(Map<id,compliancequest__SQX_Part__c> NewPartM,Map<id,compliancequest__SQX_Part__c> OldPartM){
        List<Task> TList=new List<Task>();
        
        for(Id key:NewPartM.keyset()){          
     
            if((trigger.isInsert && !NewPartM.get(key).compliancequest__Active__c)){
                Task Reltask=new task();
                Reltask.Subject='Review Part'+NewPartM.get(key).compliancequest__Part_Number__c;
                    Reltask.ActivityDate=Date.today().addDays(7);
                    Reltask.Status='Not Started';
                    Reltask.Priority='High';
                    Reltask.WhatId=key;
                TList.add(Reltask);
            }
            
        }
        List<Task> existingTasks=new List<Task>();
        if(OldPartM!=null ){
         existingTasks=[SELECT Id, Subject,Status,WhatId FROM Task WHERE WhatId IN :OldPartM.keyset()];
        }
        if(OldPartM!=null ){
            for(Task T:existingTasks){
                if(OldPartM.containskey(T.WhatId) && (trigger.isUpdate && (!OldPartM.get(T.WhatId).compliancequest__Active__c && NewPartM.get(T.WhatId).compliancequest__Active__c && NewPartM.get(T.WhatId).compliancequest__Reason_For_Change__c!=null))){
                    T.Status='Completed';
                }
            }
        }
        
        if(TList!=null){
            insert TList;
        }
        update existingTasks;
    }

}