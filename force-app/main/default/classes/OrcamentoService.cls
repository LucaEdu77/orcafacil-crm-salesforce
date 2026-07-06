public with sharing class OrcamentoService {
    public static String criarOrcamento(String nomeOrcamento, Id clienteId, Decimal valorTotal, String status, Date dataOrcamento) {
        Orcamento__c orcamento = new Orcamento__c();
        orcamento.Name = nomeOrcamento;
        orcamento.Cliente__c = clienteId;
        orcamento.Valor_Total__c = valorTotal;
        orcamento.Status__c = status;
        orcamento.Data_do_Orcamento__c = dataOrcamento;

        List<Account> clientesEncontrados = [ //Consulta para verificar se já existe um cliente com o mesmo Id no sistema.
            SELECT Id 
            FROM Account 
            WHERE Id = :clienteId
        ];

        if (clientesEncontrados.isEmpty()) { // Verifica se existe um cliente com o Id informado.
            return 'Cliente não encontrado.';
        } else {
            insert orcamento;
            return 'Orçamento cadastrado com sucesso.';
        }
    }
}