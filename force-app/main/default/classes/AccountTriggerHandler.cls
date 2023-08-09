public with sharing class AccountTriggerHandler extends TriggerHandler {
    
    private Map<Id, Account> mapOfNewAccounts;
    private Map<Id, Account> mapOfOldAccounts;
    private final Id PARCEIRO = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
    private final Id CONSUMIDOR_FINAL = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor Final').getRecordTypeId();

    public AccountTriggerHandler() {
        this.mapOfNewAccounts = (Map<Id, Account>) Trigger.newMap;
        this.mapOfOldAccounts = (Map<Id, Account>) Trigger.oldMap;
    }

    public override void afterInsert() {
        List<Opportunity> listOfOppsToInsert = new List<Opportunity>();
        List<Task> listOfTasksToInsert = new List<Task>();

        for (Id newAccId : mapOfNewAccounts.keySet()) {
            Account newCurrentAccount = mapOfNewAccounts.get(newAccId);

            if (newCurrentAccount.RecordTypeId == PARCEIRO) {
                listOfOppsToInsert.add(new Opportunity(
                    Name = newCurrentAccount.Name + ' - opp Parceiro',
                    CloseDate = System.Today().addDays(30),
                    StageName = 'Qualification',
                    AccountId = newCurrentAccount.id
                ));
            }
            
            else if (newCurrentAccount.RecordTypeId == CONSUMIDOR_FINAL) {
                listOfTasksToInsert.add(new Task(
                    Subject = 'Consumidor Final',
                    WhatId = newCurrentAccount.id,
                    Status = 'Not Started',
                    Priority = 'Normal'
                ));
            }
        }


        if (listOfOppsToInsert.size() > 0) {
            List<Database.SaveResult> result = Database.insert(listOfOppsToInsert);
            System.debug('RESULTA DA INSERÇÃO DAS OPORTUNIDADES: ');
            System.debug(listOfOppsToInsert);
        }

        if (listOfTasksToInsert.size() > 0) {
            List<Database.SaveResult> result = Database.insert(listOfTasksToInsert);
            System.debug('RESULTA DA INSERÇÃO DAS OPORTUNIDADES: ');
            System.debug(listOfTasksToInsert);
        }
    }

    public override void beforeUpdate() {

        for (Id newAccId : mapOfNewAccounts.keySet()) {
            Account newCurrentAccount = mapOfNewAccounts.get(newAccId);

            if (newCurrentAccount.Type == 'CPF') {
                if (!Utils.validaCpf(newCurrentAccount.AccountNumber)) {
                    newCurrentAccount.addError('Número do cliente é inválido');
                }
            }

            else if (newCurrentAccount.Type == 'CNPJ') {
                if (!Utils.validaCNPJ(newCurrentAccount.AccountNumber)) {
                    newCurrentAccount.addError('Número do cliente é inválido');
                }
            }
        }

        
    }
}