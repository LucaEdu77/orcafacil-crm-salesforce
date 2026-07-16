@isTest
public class ItemOrcamentoServiceTest {
    @isTest
    public static void testCriarItemOrcamento() {
        
        Account cliente = new Account( // Criação de um cliente de teste
            Name = 'Cliente de Teste',
            Phone = '1234567890',
            Website = 'www.cliente-teste.com'
        );

        insert cliente;

        OrcamentoService.criarOrcamento( // Criação de um orçamento de teste
         'Orçamento de Teste',
            cliente.Id,
            0,
            'Em aberto',
            Date.today()
        );

        Orcamento__c orcamento = [ // Consulta para obter o orçamento criado
            SELECT Id, Valor_Total__c 
            FROM Orcamento__c 
            WHERE Name = 'Orçamento de Teste'
            LIMIT 1
        ];

        // Chamada do método para criar o item de orçamento
        String resultado = ItemOrcamentoService.criarItemOrcamento(
            'Item de Teste',
            'Descrição do Item de Teste',
            2,
            50,
            orcamento.Id
        );

        // Verificação se o item foi criado com sucesso
        System.assertEquals('Item de orçamento criado com sucesso', resultado);

        // Verificação se o valor total do orçamento foi atualizado corretamente
       List<Item_do_Orcamento__c> itensCriados = [ // Consulta para obter o item de orçamento criado
            SELECT Id,
            Name,
            Quantidade__c,
            Valor_Unitario__c,
            Valor_Total__c
            FROM Item_do_Orcamento__c
            WHERE Orcamento__c = :orcamento.Id
        ];
        System.assertEquals(1, itensCriados.size());
        System.assertEquals('Item de Teste', itensCriados[0].Name);
        System.assertEquals(2, itensCriados[0].Quantidade__c);
        System.assertEquals(50, itensCriados[0].Valor_Unitario__c);
        System.assertEquals(100, itensCriados[0].Valor_Total__c);
    
    Orcamento__c orcamentoAtualizado = [ // Consulta para obter o orçamento atualizado
            SELECT Id, Valor_Total__c 
            FROM Orcamento__c 
            WHERE Id = :orcamento.Id
        ];

        System.assertEquals(100, orcamentoAtualizado.Valor_Total__c);
    }
}   