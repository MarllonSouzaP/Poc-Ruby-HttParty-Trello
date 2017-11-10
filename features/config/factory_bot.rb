class Full
  FactoryBot.define do
    name = Faker::StarWars.character
    factory :chave_de_acesso, aliases: [:chave], :class => :Full do |u|
        u.APP_KEY 'b163d32e85c8241be720a23cd903bf67' 
        u.TOKEN 'a1fcd93938f29c6e2dcee8662ead94485646e64590e057523b1e97b6c6547cad'
    end
    
    factory :list_options, aliases: [:options], :class => :Full do |u|
        u.name 'Nome Coluna'
        u.idBoard 'ffrdigital'
    end
  
    factory :board_options, :class => :Full do |u|
        u.name "teste"
        u.defaultLabels 'false'
        u.defaultLists 'false'
        u.prefs_permissionLevel 'private'
        u.prefs_voting 'disabled'
        u.prefs_comments 'members'
        u.default 'members'  
        u.default_true 'true'
        u.prefs_invitations 'members'
        u.prefs_selfJoin 'true'
        u.prefs_cardCovers 'true'
        u.prefs_background 'blue'
        u.prefs_cardAging 'regular'
    end

    factory :mensagem_exception, aliases: [:erro_msg], :class => :Full do |u|
        name_queadro = FactoryBot.attributes_for(:board_options)[:name]
        u.quadro_nao_existente { raise ArgumentError.new("Não é apresentado o quadro: #{name_queadro.upcase} no trello") }    
    end

  end
end