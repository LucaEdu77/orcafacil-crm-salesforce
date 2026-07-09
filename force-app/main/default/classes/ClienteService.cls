public with sharing class ClienteService { //Classe responsavel pelas regras de negocio do cliente.
    
    public static String cadastrarCliente(String nomeCliente, String telefoneCliente, String siteCliente) { //Metodo responsavel por cadastrar um novo cliente no sistema, recebendo como parametro o nome do cliente.

        Account cliente = new Account(); //Cria um novo objeto do tipo Account vazio.

        cliente.Name = nomeCliente; //Atribui o nome do cliente ao objeto Account.
        cliente.Phone = telefoneCliente; 
        cliente.Website = siteCliente; 

        List<Account> clientesExistentes = [ 
            SELECT Id, Name 
            FROM Account 
            WHERE Name = :nomeCliente
        ]; 

        if (clientesExistentes.isEmpty()) { 

            insert cliente;

            return 'Cliente cadastrado com sucesso.';
        } else { 
            return 'Cliente já cadastrado.';
        }
    }   
    public static List<Account> buscarClientesPorNome(String nomeCliente) { 

        List<Account> buscarClientes = [ 
            SELECT Id, Name, Phone, Website 
            FROM Account 
            WHERE Name = :nomeCliente 
        ];

        return buscarClientes; 
    }
    public static String atualizarCliente(
        String nomeCliente, 
        String novoTelefone, 
        String novoSite
    ) { //Metodo responsavel por atualizar um cliente no sistema, recebendo como parametro o id do cliente.

        List<Account> clientesExistentes = [ 
            SELECT Id, Name, Phone, Website 
            FROM Account 
            WHERE Name = :nomeCliente
        ];
        if (!clientesExistentes.isEmpty()) {
            Account cliente = clientesExistentes [0]; 
            cliente.Phone = novoTelefone; 
            cliente.Website = novoSite; 

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