public with sharing class OrcamentoService {
    public static String criarOrcamento(String nomeOrcamento, Id clienteId, Decimal valorTotal, String status, Date dataOrcamento) {
        Orcamento__c orcamento = new Orcamento__c(); // Cria um novo objeto do tipo Orcamento__c vazio.
        orcamento.Name = nomeOrcamento; //
        orcamento.Cliente__c = clienteId;
        orcamento.Valor_Total__c = valorTotal;
        orcamento.Status__c = status;
        orcamento.Data_do_Orcamento__c = dataOrcamento;

        List<Account> clientesEncontrados = [ //Consulta para verificar se o cliente existe no sistema.
            SELECT Id 
            FROM Account 
            WHERE Id = :clienteId
        ];

        if (clientesEncontrados.isEmpty()) { 
            return 'Cliente não encontrado.';
        } else {
            insert orcamento;
            return 'Orçamento cadastrado com sucesso.';
        }
    }
    
    public static List<Orcamento__c> buscarOrcamentos(String nomeOrcamento) {
        List<Orcamento__c> orcamentosEncontrados = [ 
            SELECT Id, Name, Valor_Total__c, Status__c, Data_do_Orcamento__c 
            FROM Orcamento__c 
            WHERE Name = :nomeOrcamento
        ];

        return orcamentosEncontrados;
    }

    public static String atualizarOrcamento( //Metodo responsavel por atualizar um orçamento no sistema, recebendo como parametro o nome do orçamento.
        String nomeOrcamento, 
        Decimal novoValorTotal, 
        String novoStatus, 
        Date novaDataOrcamento) { //Metodo responsavel por atualizar um orçamento no sistema, recebendo como parametro o nome do orçamento.

        List<Orcamento__c> orcamentosEncontrados = [ 
            SELECT Id, Name, Cliente__c, Valor_Total__c, Status__c, Data_do_Orcamento__c 
            FROM Orcamento__c 
            WHERE Name = :nomeOrcamento
        ];

        if (!orcamentosEncontrados.isEmpty()) { // Verifica se o orçamento existe no sistema.
            Orcamento__c orcamento = orcamentosEncontrados[0]; // Pega o primeiro orçamento encontrado na lista.
            orcamento.Valor_Total__c = novoValorTotal;  
            orcamento.Status__c = novoStatus; 
            orcamento.Data_do_Orcamento__c = novaDataOrcamento;

            update orcamento; // Atualiza o orçamento no sistema.

            return 'Orçamento atualizado com sucesso.';
        } else {
            return 'Orçamento não encontrado.';
        }
    }
    public static String excluirOrcamento(String nomeOrcamento) { //Metodo responsavel por excluir um orçamento no sistema, recebendo como parametro o nome do orçamento.
        List<Orcamento__c> orcamentosEncontrados = [ 
            SELECT Id, Name 
            FROM Orcamento__c 
            WHERE Name = :nomeOrcamento
        ];

        if (!orcamentosEncontrados.isEmpty()) { // Verifica se o orçamento existe no sistema.
            Orcamento__c orcamento = orcamentosEncontrados[0]; // Pega o primeiro orçamento encontrado na lista.
            delete orcamento; // Exclui o orçamento do sistema.
            return 'Orçamento excluído com sucesso.';
        } else {
            return 'Orçamento não encontrado.';
        }
    }
}