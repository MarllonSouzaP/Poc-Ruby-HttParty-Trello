require 'rspec'
require 'cucumber'
require 'pry'
require 'httparty'
require 'json'
require 'faker'
require 'factory_bot'
require 'rspec/core'
require 'openssl'


OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

 # Variavel de configuração de BASE_URL de ambiente
 $ambiente = 'homo' || ENV['AMBIENTE']
  # Arquivo de BASE_URL, Url de ambiente
 $base_url = YAML.load_file('./features/config/aplication.yml')[$ambiente]

