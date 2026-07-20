trigger OrcamentoTrigger on Orcamento__c (
    before insert
) {
    OrcamentoTriggerHandler.execute(
        Trigger.operationType,
        Trigger.new,
        Trigger.oldMap
    );
}