@isTest
public class ClienteServiceTest{ //Classe de teste para a classe ClienteService.
    @isTest
    public static void testCriarCliente() { 
        String nomeCliente = 'Cliente Teste';
        String telefoneCliente = '123456789';
        String siteCliente = 'www.cliente.com';

        String resultado = ClienteService.cadastrarCliente(nomeCliente, telefoneCliente, siteCliente);

        System.assertEquals('Cliente cadastrado com sucesso.', resultado);
    }

    @isTest
    public static void testBuscarCliente() { //Metodo de teste para buscar um cliente no sistema.
      
        ClienteService.cadastrarCliente( // Metodo responsavel por cadastrar um novo cliente no sistema, recebendo como parametro o nome do cliente.
            'Empresa Busca Teste', 
            '123456789', 
            'www.cliente.com'
        );

        List<Account> clientesEncontrados = ClienteService.buscarClientesPorNome(
            'Empresa Busca Teste'
        );

        System.assertEquals(1, clientesEncontrados.size());
        System.assertEquals('Empresa Busca Teste', clientesEncontrados[0].Name);
    }

    @isTest
    public static void testAtualizarCliente() { //Metodo de teste para atualizar um cliente no sistema.
        ClienteService.cadastrarCliente(
            'Empresa Atualiza Teste', 
            '123456789', 
            'www.cliente.com'
        );
        String resultado = ClienteService.atualizarCliente(
            'Empresa Atualiza Teste', 
            '987654321', 
            'www.novosite.com'
        );
        System.assertEquals('Cliente atualizado com sucesso.', resultado);

        Account clienteAtualizado = [
            SELECT Id, Name, Phone, Website      
            FROM Account
            WHERE Name = 'Empresa Atualiza Teste' LIMIT 1];

        System.assertEquals('987654321', clienteAtualizado.Phone);
        System.assertEquals('www.novosite.com', clienteAtualizado.Website);
    }

    @isTest
    public static void testExcluirCliente() { //Metodo de teste para excluir um cliente no sistema
        ClienteService.cadastrarCliente(
            'Empresa Exclui Teste', 
            '123456789', 
            'www.cliente.com'
        );
        String resultado = ClienteService.excluirCliente('Empresa Exclui Teste');
        System.assertEquals('Cliente excluído com sucesso.', resultado);

        List<Account> clienteExcluido = [
            SELECT Id 
            FROM Account 
            WHERE Name = 'Empresa Exclui Teste' LIMIT 1];
        System.assertEquals(0, clienteExcluido.size()); // Verifica se o cliente foi excluído com sucesso.
    }
}    