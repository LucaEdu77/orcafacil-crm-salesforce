@isTest
public class OrcamentoServiceTest {
    @isTest
    public static void testCriarOrcamento() {
        //Criando um cliente para associar ao orçamento, e ter um ID, pois o método de criação de orçamento exige um ID de cliente existente.
        Account cliente = new Account(
            Name = 'Cliente Teste',
            Phone = '123456789',
            Website = 'www.cliente.com'
        );
        insert cliente; //Insere o cliente no sistema para que possamos usar o ID dele no orçamento.
    }

    @isTest
    public static void testBuscarOrcamento() {
        // Primeiro, criamos um cliente e um orçamento para buscar
        Account cliente = new Account( //Criando um cliente para associar ao orçamento, e ter um ID, pois o método de criação de orçamento exige um ID de cliente existente.
            Name = 'Cliente Busca Teste',
            Phone = '123456789',
            Website = 'www.cliente.com'
        );

        insert cliente;

        OrcamentoService.criarOrcamento( //Criando um orçamento para buscar
            'Orcamento Busca Teste', 
            cliente.Id,
            1500.00,
            'Em Aberto',
            Date.today()
        );

        List<Orcamento__c> orcamentosEncontrados = 
            OrcamentoService.buscarOrcamentos('Orcamento Busca Teste');

        System.assertEquals(1, orcamentosEncontrados.size()); //busca o orçamento criado e verifica se ele foi encontrado corretamente.
        System.assertEquals('Orcamento Busca Teste', orcamentosEncontrados[0].Name); //Verifica se o nome do orçamento encontrado é o mesmo que foi criado.
    }

    @isTest
    public static void testAtualizarOrcamento() {
        // Primeiro, criamos um cliente e um orçamento para atualizar
        Account cliente = new Account(
            Name = 'Cliente Atualiza Teste',
            Phone = '123456789',
            Website = 'www.cliente.com'
        );

        insert cliente;

        OrcamentoService.criarOrcamento(
            'Orcamento Atualiza Teste', 
            cliente.Id,
            2000.00,
            'Em Aberto',
            Date.today()
        );
        
        OrcamentoService.atualizarOrcamento(
            'Orcamento Atualiza Teste', 
            2500.00, 
            'Aprovado', 
            Date.today()
        );


        List<Orcamento__c> orcamentosAtualizados = [ //Consulta para verificar se o orçamento foi atualizado corretamente.
            SELECT Id, Name, Valor_Total__c, Status__c, Data_do_Orcamento__c
            FROM Orcamento__c 
            WHERE Name = 'Orcamento Atualiza Teste' LIMIT 1
        ];

        System.assertEquals(1, orcamentosAtualizados.size()); // Verifica se o orçamento atualizado foi encontrado corretamente.
        System.assertEquals(2500.00, orcamentosAtualizados[0].Valor_Total__c);
        System.assertEquals('Aprovado', orcamentosAtualizados[0].Status__c);
        System.assertEquals(Date.today(), orcamentosAtualizados[0].Data_do_Orcamento__c);
    }
    
    @isTest
    public static void testExcluirOrcamento() {
        // Primeiro, criamos um cliente e um orçamento para excluir
        Account cliente = new Account(
            Name = 'Cliente Exclui Teste',
            Phone = '123456789',
            Website = 'www.cliente.com'
        );

        insert cliente;

        OrcamentoService.criarOrcamento(
            'Orcamento Exclui Teste',
            cliente.Id,
            1500.00,
            'Em Aberto',
            Date.today()
        );

        OrcamentoService.excluirOrcamento('Orcamento Exclui Teste');

        List<Orcamento__c> orcamentosExcluidos = [ //Consulta para verificar se o orçamento foi excluído corretamente.
            SELECT Id 
            FROM Orcamento__c 
            WHERE Name = 'Orcamento Exclui Teste'
        ];
        System.assertEquals(0, orcamentosExcluidos.size()); // Verifica se
    }
}    