public with sharing class UpdateInactiveAccounts implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'Select id, (SELECT Id FROM Tasks WHERE CreatedDate < LAST_90_DAYS) from account WHERE Id NOT IN (Select Accountid from Opportunity Where StageName = \'Negotiation/Review\' OR (StageName = \'Closed Won\' AND LastStageChangeDate < LAST_N_DAYS:120))';

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Account> accountsToUpdate = new List<Account>();

        for (Account currentAccount : scope) {
            if (currentAccount.Tasks == null || currentAccount.Tasks.isEmpty()) {
                currentAccount.Inativa__c = true;
                accountsToUpdate.add(currentAccount);
            }
        }

        if (accountsToUpdate.size() > 0) {
            List<Database.SaveResult> result = Database.update(accountsToUpdate);
            System.debug('RESULTADO DA ATUALIZAÇÃO DAS CONTAS BATCH');
            System.debug(result);
        } 
    }

    public void finish(Database.BatchableContext bc) {}
}