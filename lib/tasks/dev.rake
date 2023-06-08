namespace :dev do
  desc "Apaga, cria, migra e carrega os dados das taks: add_coins, add_mining_types"
  task setup: :environment do
    
    if Rails.env.development?
      show_spinner("Apagando db...") { %x(rails db:drop) }
      show_spinner("Criando DB...") { %x(rails db:create) }
      show_spinner("Migrando DB...") { %x(rails db:migrate) } 
      show_spinner("Populando os tipos de mineração") { %x(rails dev:add_mining_types) }
      show_spinner("Populando DB...") { %x(rails dev:add_coins) }
      msg_final()
    
    else
      puts "Voce não está em ambiente de desenvolvimento"
  end
end

desc "Cadastro de Moedas"
task add_coins: :environment do
  show_spinner("Cadastrando Moedas")do
    coins = [
   
      { 
        description: "Bitcoin",
        acronym: "BTC",
        url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmcncOyQcZatqAn2Y5A8NOC6UQ-uBDMwIqjw&usqp=CAU",
        mining_type: MiningType.all.sample
      },
        
      {
       description: "Etherium",
       acronym: "ETH",
       url_image: "https://img1.gratispng.com/20180516/ouw/kisspng-ethereum-cryptocurrency-blockchain-logo-eos-io-crypto-5afc9ab9b20d86.8643914515265041217293.jpg",
       mining_type: MiningType.all.sample
      },

      { 
       description: "Dash",
       acronym: "DASH",
       url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
       mining_type: MiningType.all.sample
      }
      
    ]
    
    coins.each do |coin|
      Coin.find_or_create_by!(coin)
  end

end
end

desc "Cadastro dos tipos de mineração"
task add_mining_types: :environment do
  #show_spinner("Populando o tipo de mineração")
  mining_types = [
    
    {description: "Proof of Work", acronym: "PoW"},
    {description: "Proof of Stake", acronym: "PoS"}, 
    {description: "Proof of Capacity", acronym: "PoC"}

  ]

  mining_types.each do |mining_type|
    MiningType.find_or_create_by!(mining_type) 
end

end

private

def show_spinner(msg_start) 
  spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
  spinner.auto_spin
  yield
  end


def msg_final
  puts ""
  spinner = TTY::Spinner.new("[:spinner]")
  spinner.auto_spin
  spinner.success("Feito")
end
end