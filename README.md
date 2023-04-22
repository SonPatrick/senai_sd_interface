# Processo seletivo - QA

Bem vindo, candidato. 

Estamos felizes que você esteja participando do processo seletivo para a vaga de QA do Senai - Soluções Digitais.

A prova deverá utilizar as seguintes tecnologias: 
- Linguagem de programação orientada a objeto para web
- Banco de dados relacional
- GIT

Fica à sua escolha quais frameworks e servidor serão utilizados, desde que seja uma aplicação web. 

Na etapa da entrevista deverá ser apresentado a aplicação em funcionamento.

## Instruções para a execução da prova

A prova deve ser uma aplicação web. Você pode escolher a tecnologia que achar conveniente (PHP, JAVA, etc...).

O Banco utilizado na prova deve ser PostgrSQL.

Esse repositório possui apenas esse Readme com as instruções da prova. No entanto, **todo desenvolvimento deve ser commitado nesse repositório** até a data citada no email, enviado por nossa equipe.

Commite nesse repositório o script utilizado na criação do banco de dados (se aplicável).

Por fim, altere esse arquivo com as instruções de como poderemos testar o seu código (quais libs usar, qual servidor, etc) abaixo.

## Será avaliado
- Qualidade do código quanto a:
  - Facilidade no entedimento
  - Complexidade ciclomática
  - Divisão de resposabilidade das classes
  - Reutilização de código
- Qualidade quanto a interface:
  - Fácil usabilidade
  - Acessibilidade
  - Feedback ao usuário
- Qualidade quanto aos requisitos:
  - Desenvolvimento e funcionamento dos requisitos propostos.

## Informações extras

- Descreva ao final deste documento (Readme.md) o detalhamento de funcionalidades implementadas, sejam elas já descritas na modelagem e / ou extras.
- Detalhar também as funcionalidades que não conseguiu implementar e o motivo.
- Caso tenha adicionado novas libs ou frameworks, descreva quais foram e porque dessa agregação.

(Escreva aqui as instruções para que possamos corrigir sua prova, bem como qualquer outra observação sobre a prova que achar pertinente compartilhar)

</br></br>
# DOCUMENTAÇÃO DO SISTEMA
</br>

# senai_sd
Projeto desenvolvido para o teste prático do processo seletivo do FIESC.

## Descrição das funcionalidades implementadas

### Tecnologias utilizadas
O Projeto foi implementado utilizando as tecnologias/Frameworks:

    Flutter
    Node.js
    Postgres

A Arquitetura do sistema é monolítica, significando que a interface de usuário enconrta-se no mesmo projeto que a API e as respectivas regras de negócio.</br></br>

A interface foi construída usando a linguagem `Dart` e o `Framework Flutter`, que **renderizou a interface otimizada para Web**  que foi integrada junto ao projeto, formando o **monolito** da aplicação.</br>
O código da interface do usuário pode ser encontrado e analisado [aqui](https://github.com/SonPatrick/senai_sd_interface).</br></br>


A Aplicação Web foi construída usando `Javascript` com o framework `Node.js` e as bibliotecas:
    
> **connect-timeout**: Gerencia o tempo de requisição,
> 
> **cookie-parser**: Analisador e serializador básico de cookies HTTP para servidores HTTP,
> 
> **cors**: Pacote node.js para fornecer um middleware Connect/Express que pode ser usado para habilitar o CORS,
> 
> **dotenv**: Carrega as variáveis de ambiente;
> 
> **express**: Framework que oferece uma estrutura para a criação de servidores web de forma minimalista e rápida;
> 
> **helmet**: Biblioteca para proteger as requisições atribuindo cabeçalho às requisiçãoes;
> 
> **morgan**: Biblioteca para registro de logs de eventos no servidor;
> 
> **pg**: Biblioteca para conexão com o Postgres</br></br>

## Para testar a aplicação

Você precisa ter instalado o `Node.js v18.9.0` ou superior e o `Postgres` em sua máquina.</br></br>
As variáveis de ambiente estão no arquivo `.env` na raíz do projeto e pode ser alterada de acordo com o host, usuário, nome do banco de dados, a senha e a porta.

> 1. Inicie Postgres
> 2. Inicialize a aplicação Node.js com o comando:  `node app.js`
> 3. Abra o navegador e digite: `http://localhost:3000/` para acessar a aplicação;

## Extras
 Caso desejar, você pode gerar as imagens do **Docker** para rodar a aplicação dentro dos contêineres em servidores cloud que suportam `Node.js` e `Postgres`.

## Login

Para entrar no sistema, é criado um usuário padrão no processo de migração das tabelas do banco de dados na execução do aplicativo. Seguem os dados:

### USUÁRIO  `FIESC`
    
    Login: root@fiesc.com
    Senha: fiesc


### USUÁRIO  `SENAI`
    Login: senai@fiesc.com
    Senha: senai

Com esses dados você pode entrar no sistema para acessar as funcionalidades implementadas, que são

    [X] Login de usuário
    [X] Exibição das tarefas cadastradas
    [ ] Criação de tarefas
    [ ] Transderẽncia de tarefas
    [ ] Atualização de tarefas

## Dos recursos não implementados
