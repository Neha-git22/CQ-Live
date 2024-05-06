trigger Part_Neha_Trigger on compliancequest__SQX_Part__c (After Insert,After Update) {
    
        
    Part_Neha_Handler.HandleCase(trigger.newMap,trigger.oldMap);

}