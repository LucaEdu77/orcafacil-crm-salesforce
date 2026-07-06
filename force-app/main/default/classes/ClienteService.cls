public with sharing class ClienteService { //Classe responsavel pelas regras de negocio do cliente.
    
    public static String cadastrarCliente(String nomeCliente, String telefoneCliente, String siteCliente) { //Metodo responsavel por cadastrar um novo cliente no sistema, recebendo como parametro o nome do cliente.

        Account cliente = new Account(); //Cria um novo objeto do tipo Account vazio.

        cliente.Name = nomeCliente; //Atribui o nome do cliente ao objeto Account.
        cliente.Phone = telefoneCliente; //Atribui o telefone do cliente ao objeto Account.
        cliente.Website = siteCliente; //Atribui o site do cliente ao objeto Account

        List<Account> clientesExistentes = [ //Consulta para verificar se já existe um cliente com o mesmo nome no sistema.
            SELECT Id, Name 
            FROM Account 
            WHERE Name = :nomeCliente
            //Filtra os registros da tabela Account pelo nome do cliente recebido como parametro.
        ]; 

        if (clientesExistentes.isEmpty()) { //Verifica se a lista de clientes existentes está vazia, ou seja, se não existe nenhum cliente com o mesmo nome no sistema.

            insert cliente;

            return 'Cliente cadastrado com sucesso.';
        } else { 
            return 'Cliente já cadastrado.';
        }
    }   
    public static List<Account> buscarClientesPorNome(String nomeCliente) { //Metodo responsavel por buscar clientes no sistema, recebendo como parametro o nome do cliente.

        List<Account> buscarClientes = [ //Consulta para buscar clientes no sistema pelo nome.
            SELECT Id, Name, Phone, Website 
            FROM Account 
            WHERE Name = :nomeCliente 
        ];

        return buscarClientes; //Retorna a lista de clientes encontrados.
    }
    public static String atualizarCliente(
        String nomeCliente, 
        String novoTelefone, 
        String novoSite
    ) { //Metodo responsavel por atualizar um cliente no sistema, recebendo como parametro o id do cliente.

        List<Account> clientesExistentes = [ //Consulta para verificar se já existe um cliente com o mesmo nome no sistema.
            SELECT Id, Name, Phone, Website 
            FROM Account 
            WHERE Name = :nomeCliente
        ];
        if (!clientesExistentes.isEmpty()) {
            Account cliente = clientesExistentes [0]; //Pega o primeiro cliente encontrado na lista de clientes existentes.
            cliente.Phone = novoTelefone; //Atualiza o telefone do cliente.
            cliente.Website = novoSite; //Atualiza o site do cliente.

            update cliente;

            return 'Cliente atualizado com sucesso.';
        } else {
            return 'Cliente não encontrado.';
        }
    }
    public static String excluirCliente(String nomeCliente) {
        List<Account> clientesExistentes = [ //Consulta para verificar se já existe um cliente com o mesmo nome no sistema.
            SELECT Id, Name 
            FROM Account 
            WHERE Name = :nomeCliente
        ];
        if (!clientesExistentes.isEmpty()) {
            Account cliente = clientesExistentes [0];

            delete cliente;

            return 'Cliente excluído com sucesso.';
        } else {
            return 'Cliente não encontrado.';
        }
    }
}    