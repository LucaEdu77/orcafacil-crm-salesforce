public with sharing class OrcamentoTriggerHandler { 

    public static void execute( 
        System.TriggerOperation operation, 
        List<Orcamento__c> newList,
        Map<Id, Orcamento__c> oldMap
    ) {
        switch on operation {
            when BEFORE_INSERT {
                beforeInsert(newList);
            }

            when else {
                // Outros eventos ainda não são utilizados
            }
        }
    }

    private static void beforeInsert(
     List<Orcamento__c> novosOrcamentos
) {
    OrcamentoService.definirStatusInicial(novosOrcamentos);
    OrcamentoService.validarValorTotal(novosOrcamentos);
    }
}   