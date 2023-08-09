global class ScheduleUpdateInactiveAccountsBatch implements Schedulable {
    public static String CRON = '';

    global void execute(SchedulableContext sc) {
        UpdateInactiveAccounts up = new UpdateInactiveAccounts();
        Database.executeBatch(up);
    }

    public static Set<Id> run() {
        Set<Id> jobIds = new Set<Id>();
        jobIds.add(System.schedule('Execução Batch Contas 5 horas', '0 0 5 ? * 2-6', new ScheduleUpdateInactiveAccountsBatch()));
        jobIds.add(System.schedule('Execução Batch Contas 12 horas', '0 0 12 ? * 2-6', new ScheduleUpdateInactiveAccountsBatch()));
        jobIds.add(System.schedule('Execução Batch Contas 18 horas', '0 0 18 ? * 2-6', new ScheduleUpdateInactiveAccountsBatch()));
        jobIds.add(System.schedule('Execução Batch Contas 23 horas', '0 0 23 ? * 2-6', new ScheduleUpdateInactiveAccountsBatch()));

        return jobIds;
    }
}