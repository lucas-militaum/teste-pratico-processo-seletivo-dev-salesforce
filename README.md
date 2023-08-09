# Teste técnico realizado para processo seletivo

## Ferramentas Utilizadas

- [Framework Trigger handler](https://github.com/kevinohara80/sfdc-trigger-framework)
- Vscode
- Github

## Tarefas

- [x] Desenvolvimento de Lightning Component

- [x] Desenvolvimento da Trigger para o Objeto Account

- [x] Desenvolvimento de classe implementando interface Batchable para atualização de contas inativas

- [x] Desenvolvimento de classe implementando interface Schedulable para agendamente de classe batch

- [x] Desenvolvimento das classes de teste

## Arquivos para análise

### Features

- [Componente Lightning](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/aura/editAccountLightningComponent/editAccountLightningComponent.cmp)

- [Trigger Account](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/classes/AccountTriggerHandler.cls)

- [Classe Batch](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/classes/UpdateInactiveAccounts.cls)

- [Classe Schedule](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/classes/ScheduleUpdateInactiveAccountsBatch.cls)

### Classes de Teste

- [Classe Test Batch](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/classes/UpdateInactiveAccountsTest.cls)

- [Classe Test Schedule](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/classes/ScheduleUpdateInactiveAccountsBatchTest.cls)

- [Classe Test Trigger](https://github.com/lucas-militaum/teste-pratico-processo-seletivo-dev-salesforce/blob/master/force-app/main/default/classes/AccountTriggerTest.cls)
