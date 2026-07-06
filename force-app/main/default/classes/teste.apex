Account cliente = [
    SELECT Id, Name
    FROM Account
    LIMIT 1
];

String resultado = OrcamentoService.criarOrcamento(
    'Orçamento 001',
    cliente.Id,
    1500.00,
    'Em Aberto',
    Date.today()
);

System.debug(resultado);