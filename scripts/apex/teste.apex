List<Orcamento__c> orcamentos;
    orcamentos = OrcamentoService.buscarOrcamentos('Orçamento 001');
    System.debug(orcamentos);