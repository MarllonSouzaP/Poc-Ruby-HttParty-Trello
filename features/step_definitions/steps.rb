
Dado(/^tenha um usuário com acesso ao Trello$/) do
  chave_de_acesso = FactoryBot.attributes_for(:chave_de_acesso)
  @trello_api = TrelloApi.new(chave_de_acesso[:APP_KEY], chave_de_acesso[:TOKEN])
  @response = @trello_api.get_all_user_info
  expect(@response.code).to eq 200
end

Quando(/^criar um quadro no Trello com o nome$/) do
  @nome_quadro = FactoryBot.attributes_for(:board_options)[:name]
  @response = @trello_api.create_board(FactoryBot.attributes_for(:board_options))
end

Então(/^é criado o quadro no Trello com sucesso$/) do
  aggregate_failures do
   expect(@response.code).to eq 200
   expect(@response['name']).to eq @nome_quadro
  end
  @id_board = @response['id']
end

Quando(/^incluo as listas$/) do |table|
  @list_options = FactoryBot.attributes_for(:board_options)
  @list_options[:idBoard] =  @id_board
  @board_list = table.raw
  @board_list.reverse.each do |item|
    @list_options[:name] = item.first
    @response = @trello_api.create_list(@list_options)
    expect(@response.code).to eq 200
  end
end

Então(/^verifico que as listas foram incluídas com sucesso em meu quadro$/) do
   @response = @trello_api.get_lists_board(@id_board)
   expect(@response.code).to eq 200
   TrelloUtils.new.validar_lista_incluida_no_trello(@board_list.count-1, @board_list, @response)
end


Dado(/^e obtenha o id do quadro através do nome$/) do
  @lista_ids = []
  @nome_quadro = FactoryBot.attributes_for(:board_options)[:name]
  @response.each do |quadro|
  quadro['name'] == @nome_quadro ? @lista_ids << quadro['id'] : false
  end
   ApplicationException.new.exception_id_nao_existente(@lista_ids)
end

Quando(/^deletar o quadro pelo id$/) do
  #id_usuario = @response.first['memberships'].first['idMember']
  @lista_ids.each do |quadro_id|
    @response = @trello_api.close_board(quadro_id, { 'closed' => 'true' })
    expect(@response.code).to eq 200
    @response = @trello_api.delete_board(quadro_id)
    expect(@response.code).to eq 200
  end
end

Então(/^quadro não é apresentado e deletado com sucesso$/) do
  @response = @trello_api.get_all_user_info
  expect(@response.code).to eq 200
  @response.each do |quadro|
  expect(quadro['name']).not_to eq @nome_quadro
  end
end