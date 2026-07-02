public with sharing class ClienteService { //Classe responsavel pelas regras de negocio do cliente.
    
    public static String cadastrarCliente(String nomeCliente, String telefoneCliente, String siteCliente) { //Metodo responsavel por cadastrar um novo cliente no sistema, recebendo como parametro o nome do cliente.

        Account cliente = new Account(); //Cria um novo objeto do tipo Account vazio.

        cliente.Name = nomeCliente; //Atribui o nome do cliente ao objeto Account.
        cliente.Phone = telefoneCliente; //Atribui o telefone do cliente ao objeto Account.
        cliente.Website = siteCliente; //Atribui o site do cliente ao objeto Account

        List<Account> clientesExistentes = [ //Consulta para verificar se já existe um cliente com o mesmo nome no sistema.
            SELECT Id, Name //Seleciona os campos Id e Name da tabela Account.
            FROM Account //Seleciona a tabela Account.
            WHERE Name = :nomeCliente
            //Filtra os registros da tabela Account pelo nome do cliente recebido como parametro.
        ]; 

        if (clientesExistentes.isEmpty()) { //Verifica se a lista de clientes existentes está vazia, ou seja, se não existe nenhum cliente com o mesmo nome no sistema.
            insert cliente;
            return 'Cliente cadastrado com sucesso.';
        } else { 
            System.debug('Cliente já cadastrado.');
            return 'Cliente já cadastrado.';
        }
    }   
}