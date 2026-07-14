public with sharing class ItemOrcamentoService {

    public static string criarItemOrcamento( // Método para criar um item de orçamento
        String nomeItem,
        String descricao,
        Decimal quantidade,
        Decimal valorUnitario,
        Id orcamentoId
    ) {
        Item_Orcamento__c item = new Item_Orcamento__c(); // Cria uma nova instância do objeto Item_Orcamento__c
        item.Name = nomeItem;
        item.Descricao__c = descricao;
        item.Quantidade__c = quantidade;
        item.Valor_Unitario__c = valorUnitario;
        item.Orcamento__c = orcamentoId;

        List<Orcamento__c> orcamentosEncontrados = [ // Consulta para verificar se o orçamento existe
        SELECT Id 
        FROM Orcamento__c 
        WHERE Id = :orcamentoId
        ];

        if (orcamentosEncontrados.isEmpty()) { // Se não encontrar o orçamento, retorna uma mensagem de erro
            return 'Orcamento não encontrado';
        }
        else { // Se encontrar o orçamento, insere o item de orçamento e retorna uma mensagem de sucesso
            insert item; // Insere o item de orçamento no banco de dados
            atualizarValorTotalOrcamento(orcamentoId); // Chama o método para atualizar o valor total do orçamento
            return 'Item de orçamento criado com sucesso';
        }
    }
    
    private static void atualizarValorTotalOrcamento(Id orcamentoId) { // Método privado para atualizar o valor total do orçamento

        List<Item_Orcamento__c> itens = [ // Consulta para obter todos os itens de orçamento relacionados ao orçamento
            SELECT Id, Valor_total__c
            FROM Item_Orcamento__c 
            WHERE Orcamento__c = :orcamentoId
        ];

        Decimal valorTotal = 0; // Inicializa o valor total em zero
        for (Item_Orcamento__c item : itens) { // Soma o valor total de cada item de orçamento, um por um
            valorTotal += item.Valor_total__c; // Adiciona o valor total do item ao valor total do orçamento
        }

        Orcamento__c orcamento = [ // Consulta para obter o orçamento específico
            SELECT Id, Valor_Total__c 
            FROM Orcamento__c 
            WHERE Id = :orcamentoId
        ];

        orcamento.Valor_Total__c = valorTotal; // Atualiza o valor total do orçamento com a soma dos valores totais dos itens
        update orcamento;
    }

    public static String excluirOrcamentoItem(Id itemId) { // Método para excluir um item de orçamento
        List<Item_Orcamento__c> itensEncontrados = [ // Consulta para obter o item de orçamento específico
            SELECT Id, Orcamento__c 
            FROM Item_Orcamento__c 
            WHERE Id = :itemId
        ];

        if (itensEncontrados.isEmpty()) { // Se não encontrar o item, retorna uma mensagem de erro
            return 'Item de orçamento não encontrado';
        }
        else { 
            Id orcamentoId = itensEncontrados[0].Orcamento__c; // Armazena o ID do orçamento relacionado ao item

            delete itensEncontrados[0]; // Exclui o item de orçamento do banco de dados

            atualizarValorTotalOrcamento(orcamentoId); 

            return 'Item de orçamento excluído com sucesso';
        }
    }
}    
