@istest
public class Neha_Test_PartTrigger {
    
    @testSetup
    public static void Test(){
        Profile Pro = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        
        PermissionSet Pset=[SELECT Id From PermissionSet WHERE Name='CQ_Admin_PermissionSet_Neha'];
        
        User U1=new User();
        U1.UserName='SandTest@abcomp.com';
        U1.LastName='SandTest-User';
        U1.Alias = 'Tuse';
        U1.Email='TestSand@abcomp.com';
        U1.EmailEncodingKey='UTF-8'; 
        U1.LanguageLocaleKey='en_US';
        U1.LocaleSidKey='en_US';
        U1.ProfileId = Pro.Id;
        U1.TimeZoneSidKey='America/Los_Angeles'; 
        insert U1;
        
        PermissionSetAssignment PSAssign = new PermissionSetAssignment();
        PSAssign.AssigneeId = U1.Id;
        PSAssign.PermissionSetId = Pset.Id;
        insert PSAssign;
        
        
        
    }
    
    @istest
    public static void Test_INS_POS(){
        User U1=[SELECT Id, Name FROM User WHERE Username='SandTest@abcomp.com'];
        
        System.runAs(U1){
            compliancequest__SQX_Part_Family__c PartFam=new compliancequest__SQX_Part_Family__c();
            PartFam.Name='Neha-Partfam';
            insert PartFam;
            
            compliancequest__SQX_Part__c P1=new compliancequest__SQX_Part__c();
            P1.Name='Neha-Test';
            P1.compliancequest__Part_Number__c='9978';
            P1.compliancequest__Part_Risk_Level__c=1;
            P1.compliancequest__Part_Family__c=PartFam.Id;
            insert P1;
            
            List<task> Tasks=[SELECT Id,WhatId FROM Task WHERE WhatId=:P1.Id];
            
            System.assertEquals(1,Tasks.size());
        }
    }
    
    @istest
    public static void Test_UPD_POS(){
        
        User U1=[SELECT Id, Name FROM User WHERE Username='SandTest@abcomp.com'];
        
        System.runAs(U1){
            compliancequest__SQX_Part_Family__c PartFam=new compliancequest__SQX_Part_Family__c();
            PartFam.Name='Neha-Partfam';
            insert PartFam;
            
            compliancequest__SQX_Part__c P1=new compliancequest__SQX_Part__c();
            P1.Name='Neha-Test';
            P1.compliancequest__Part_Number__c='9978';
            P1.compliancequest__Part_Risk_Level__c=1;
            P1.compliancequest__Part_Family__c=PartFam.Id;
            insert P1;
            
                        
            P1.compliancequest__Active__c=true;
            P1.compliancequest__Reason_For_Change__c='CHANGE';
            update P1;
            
            Task Tasks=[SELECT Id,WhatId,Status FROM Task WHERE WhatId=:P1.Id];
            
            System.assertEquals('Completed',Tasks.Status);
        }
    }

}
