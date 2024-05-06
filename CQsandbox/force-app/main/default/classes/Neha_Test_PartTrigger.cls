@istest
public class Neha_Test_PartTrigger {
    
    @testSetup
    public static void Test(){
        /*Profile P1=[SELECT Name, Id FROM Profile WHERE Name='Standard User'];
        
        PermissionSet PerSet1=[SELECT Id, Label FROM PermissionSet WHERE Label='CQ_Admin_PermissionSet_Neha'];
        
        User U1=new User();
            U1.Username='Neha@123gmail.com';
            U1.Email='Neha@123gmail.com';
            U1.Alias='ne123';
            U1.TimeZoneSidKey=
            U1.LanguageLocaleKey */
        
        compliancequest__SQX_Part_Family__c PartFam=new compliancequest__SQX_Part_Family__c();
        PartFam.Name='Neha-Partfam';
        insert PartFam;
        
        compliancequest__SQX_Part__c P1=new compliancequest__SQX_Part__c();
        P1.Name='Neha-Test';
        P1.compliancequest__Part_Number__c='9978';
        P1.compliancequest__Part_Risk_Level__c=1;
        P1.compliancequest__Part_Family__c=PartFam.Id;
        insert P1;
        
    }
    
    @istest
    public static void Test_INS_POS(){
        compliancequest__SQX_Part__c Part=[SELECT Id,Name FROM compliancequest__SQX_Part__c WHERE Name='Neha-Test'];
        
        List<task> Tasks=[SELECT Id,WhatId FROM Task WHERE WhatId=:Part.Id];
        
        System.assertEquals(1,Tasks.size());
    }
    
    @istest
    public static void Test_UPD_POS(){
        compliancequest__SQX_Part__c Part=[SELECT Id,Name,compliancequest__Active__c FROM compliancequest__SQX_Part__c WHERE Name='Neha-Test'];
        
        Part.compliancequest__Active__c=true;
        Part.compliancequest__Reason_For_Change__c='CHANGE';
        update Part;
        
        Task Tasks=[SELECT Id,WhatId,Status FROM Task WHERE WhatId=:Part.Id];
        
        System.assertEquals('Completed',Tasks.Status);
    }

}