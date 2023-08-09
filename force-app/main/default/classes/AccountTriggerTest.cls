@isTest
public with sharing class AccountTriggerTest {

    @isTest
    private static void updateAccountCPFSuccess() {
        Account acc = new Account(
            Name = 'Conta Teste'
        );
        
        insert acc;

        String cpf = '59151349043';

        acc.AccountNumber = cpf;
        acc.Type = 'CPF';
        
        update acc;

        System.assertEquals(true, acc.AccountNumber == cpf, 'Atualização do CPF da conta falhou!');
    }

    @isTest
    private static void updateAccountCNPJSuccess() {
        Account acc = new Account(
            Name = 'Conta Teste'
        );
        
        insert acc;

        String cnpj = '79274174000100';

        acc.AccountNumber = cnpj;
        acc.Type = 'CNPJ';
        
        update acc;

        System.assertEquals(true, acc.AccountNumber == cnpj, 'Atualização do CNPJ da conta falhou!');
    }

    @isTest
    private static void updateAccountCPFFailure() {
        Account acc = new Account(
            Name = 'Conta Teste'
        );
        
        insert acc;

        String cpf = '332211';

        acc.AccountNumber = cpf;
        acc.Type = 'CPF';
        try {
            update acc;
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Número do cliente é inválido'));
        }
    }

    @isTest
    private static void updateAccountCNPJFailure() {
        Account acc = new Account(
            Name = 'Conta Teste'
        );
        
        insert acc;

        String cnpj = '112233';

        acc.AccountNumber = cnpj;
        acc.Type = 'CNPJ';
        
        try {
            update acc;
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Número do cliente é inválido'));
        }
    }

    @isTest
    private static void insertAccountParceiro() {
        Account novaConta = new Account(
            Name = 'Conta Parceiro',
            Industry = 'Tecnologia',
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId()
        );

        insert novaConta;

        List<Opportunity> partnerOppsCreated = [SELECT Id FROM Opportunity WHERE Name LIKE '% - opp Parceiro'];

        System.assert(partnerOppsCreated.size() == 1);
    }

    @isTest
    private static void insertAccountConsumidorFinal() {
        Account novaConta = new Account(
            Name = 'Conta Consumidor Final',
            Industry = 'Tecnologia',
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor Final').getRecordTypeId()
        );

        insert novaConta;

        List<Task> finalConsumerTasksCreated = [SELECT Id FROM Task WHERE Subject = 'Consumidor Final'];

        System.assert(finalConsumerTasksCreated.size() == 1);
    }

    @isTest
    private static void insertAccountParceiroInBulk() {
        List<Account> novasContas = new List<Account>();

        for (Integer i = 0; i < 100; i++) {
            Account novaConta = new Account(
                Name = 'Conta ' + i,
                Industry = 'Tecnologia',
                RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId()
            );
            
            novasContas.add(novaConta);
        }

        insert novasContas;

        List<Opportunity> partnerOppsCreated = [SELECT Id FROM Opportunity WHERE Name LIKE '% - opp Parceiro'];

        System.assert(partnerOppsCreated.size() == 100);
    }

    @isTest
    private static void insertAccountConsumidorFinalInBulk() {
        List<Account> novasContas = new List<Account>();
        
        for (Integer i = 0; i < 100; i++) {
            Account novaConta = new Account(
                Name = 'Conta ' + i,
                Industry = 'Tecnologia',
                RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor Final').getRecordTypeId()
            );
            
            novasContas.add(novaConta);
        }

        insert novasContas;

        List<Task> finalConsumerTasksCreated = [SELECT Id FROM Task WHERE Subject = 'Consumidor Final'];

        System.debug('TAREFAS');
        System.debug(finalConsumerTasksCreated);

        System.assert(finalConsumerTasksCreated.size() == 100);
    }

}