@isTest
public class UpdateInactiveAccountsTest {
    @isTest
    static void batchExecutionTestSuccess() {
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'Conta Teste 1'),
            new Account(Name = 'Conta Teste 2')
        };

        insert testAccounts;

        Test.startTest();
        UpdateInactiveAccounts batchUpdateAccount = new UpdateInactiveAccounts();
        Id batchId = Database.executeBatch(batchUpdateAccount);
        Test.stopTest();

        String batchStatus = [SELECT Status FROM AsyncApexJob WHERE Id = :batchId].Status;

        System.assertEquals('Completed', batchStatus);

        List<Account> accts = [SELECT id, Inativa__c FROM Account];

        System.assert(accts[0].Inativa__c == true);
    }
}