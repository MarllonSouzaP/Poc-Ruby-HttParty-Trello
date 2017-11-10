class TrelloApi
  include HTTParty

  def initialize(app_key, token)
    @autorization = {'key' => app_key, 'token' => token}
  end

  def get_all_user_info
    valor = FactoryBot.attributes_for(:list_options)[:idBoard]
    self.class.get($base_url['base_url'] + "/member/#{valor}/boards", :query => @autorization)
  end

  def get_board(id_board)
    self.class.get($base_url['base_url'] + "/boards/#{id_board}", :query => @autorization)
  end

  def create_board(board_options)
    self.class.post($base_url['base_url'] + "/boards", :query => board_options.merge!(@autorization))
  end

  def get_lists_board(id_board)
    self.class.get($base_url['base_url'] + "/boards/#{id_board}/lists?", :query => @autorization)
  end

  def create_card(card_options)
    self.class.post($base_url['base_url'] + "/cards", :query => @autorization)
  end

  def create_list(list_options)
    self.class.post($base_url['base_url'] + '/lists', :query => list_options.merge!(@autorization))
  end

  def close_board(id_board, close_board_options)
    self.class.put($base_url['base_url'] + "/boards/#{id_board}", :query => close_board_options.merge!(@autorization))
  end

  def delete_board(id_board)
    self.class.delete($base_url['base_url'] + "/boards/#{id_board}", :query => @autorization)
  end

end

class ApplicationException
  def exception_id_nao_existente(valor1)
    if valor1 == [] 
      FactoryBot.attributes_for(:erro_msg)[:quadro_nao_existente]   
     else
      puts(valor1)
    end
  end
end

class TrelloUtils
  require 'rspec'
  include RSpec::Matchers
  def validar_lista_incluida_no_trello(valor, board_list, response)
    (0..valor).each do |i|
      expect(board_list[i].join).to eq response[i]['name']
    end
  end
end