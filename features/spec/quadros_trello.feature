  #language: pt
  @quadros

  Funcionalidade: Quadros Trello
  Eu como usuário da aplicação Trello
  Desejo utilizar das funcionlidades criar e deletar um quadro
  Para controlar minhas atividades no Trello

  @criar_quadro
  Cenário: Criar Quadro Kanban Ágil
  Dado tenha um usuário com acesso ao Trello
  Quando criar um quadro no Trello com o nome
  Então é criado o quadro no Trello com sucesso
  Quando incluo as listas
  |Backlog     |
  |ToDo        |
  |In Progress |
  |Testing     |
  |Done        |
  Então verifico que as listas foram incluídas com sucesso em meu quadro

  @deletar_quadro
  Cenário: Deletar um Quadro por nome
  Dado tenha um usuário com acesso ao Trello
  E e obtenha o id do quadro através do nome
  Quando deletar o quadro pelo id
  Então quadro não é apresentado e deletado com sucesso
