@isTest
private class ScheduleUpdateInactiveAccountsBatchTest {
    @isTest
    static void testAgendadorBatchSchedule() {
        Test.startTest();
        
        Set<id> jobIds = ScheduleUpdateInactiveAccountsBatch.run();
        
        List<CronTrigger> cronTriggers = [SELECT Id, CronExpression, NextFireTime FROM CronTrigger WHERE Id IN :jobIds];
        
        System.assertEquals(3, cronTriggers.size(), 'Erro no retorno de jobs agendados!');
        
        Test.stopTest();
    }
}