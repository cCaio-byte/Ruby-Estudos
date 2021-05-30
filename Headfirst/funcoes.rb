require_relative "classes"

# LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 
def carregar_livros
  livros = []
  File.open("banco_de_dados_livros.txt") do |file|
    file.each do |line| 
      id, genero, titulo, autor, paginas, precos = line.chomp.split("|")
      livros << Livro.new(id.to_i, genero, titulo, autor, paginas.to_i, precos.to_f)
    end 
  end
  return livros
end


# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_livros_banco_de_dados(estante)
  
  while true
    print "ESCREVA O TÍTULO DO LIVRO: "
    titulo_livro = gets.chomp.strip.upcase
    livro_no_estoque = false 
    for livro in estante.livros 
        if livro.titulo == titulo_livro
            puts "LIVRO JÁ EXISTENTE NO ESTOQUE"
            livro_no_estoque = true
            break
        end 
    end 
    if livro_no_estoque = false
      print " INFORME O ID DO LIVRO: "
      id = gets.chomp.to_i
      print " INFORME O GENÊRO DO LIVRO: "
      genero = gets.chomp
      print " INFORME O TÍTULO DO LIVRO: "
      titulo = gets.chomp
      print " INFORME O AUTOR DO LIVRO: "
      autor = gets.chomp
      print " INFORME O NÚMERO DE PÁGINAS DO LIVRO: "
      paginas = gets.chomp.to_i
      print "INFORME O PREÇO DO LIVRO: "
      preco = gets.chomp.to_f

      File.open("banco_de_dados_livros.txt", "a") do |arquivo|
        arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
      end
      puts "LIVRO ADICIONADO COM SUCESSO!"
    end 
    puts "\nVOCÊ DESEJA ADICIONAR UM LIVRO DIFERENTE [Sim - 1] [Não - 2]: "
    decisao_funcionario = validar_entrada(2)
    if decisao_funcionario == 2
      break
    end
  end
end 


# CALCULA O FRETE E RETORNA A SOMA DO FRETE COM O SUBTOTAL
def calcular_valor_final(subtotal)
  puts "ESCOLHA SEU FRETE"
  print """\n[1] PAC >> 10 - 15 DIAS PARA ENTREGA | R$25,00
[2] SEDEX >> 2 - 6 DIAS PARA ENTREGA | R$40,00 
FRETE: """
  opção_frete_cliente = validar_entrada(2)
  if opção_frete_cliente == 1
    total = 25 + subtotal
    puts "                                                                                      [TOTAL = R$#{total}]"
  else 
    total = 40 + subtotal
    puts "                                                                                      [TOTAL = R$#{total}]"
  end 
  return total 
end 

# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_clientes_banco_de_dados
  while true
    print "INFORME O SEU NOME COMPLETO: "
    nome = gets.chomp.strip.upcase
    print "INFORME O DIA DO SEU NASCIMENTO: "
    dia_nascimento = gets.chomp.strip
    print "INFORME O MES DO SEU NASCIMENTO: "
    mes_nascimento = gets.chomp.strip
    print "INFORME O ANO DO SEU NASCIMENTO: "
    ano_nascimento = gets.chomp.strip
    print "INFORME O ESTADO: "
    estado = gets.chomp.strip.upcase
    print "INFORME A SUA CIDADE: "
    cidade = gets.chomp.strip.upcase
    print "INFORME O NÚMERO DA SUA RESIDÊNCIA: "
    numero = gets.chomp.strip
    print "INFORME O SEU CEP: "
    cep = gets.chomp.strip

    print "\nINFORME O SEU E-MAIL PARA LOGIN: "
    e_mail = gets.chomp.strip.downcase

    print "\nINFORME O SUA SENHA PARA LOGIN: "
    senha = gets.chomp.strip.downcase

    puts("""NOME: [#{nome}]
DATA DE NASCIMENTO: #{dia_nascimento}/#{mes_nascimento}/#{ano_nascimento}
ENDEREÇO: ESTADO[#{estado}] CIDADE[#{cidade}] NUMERO[#{numero}] CEP[#{cep}]
E-MAIL: [#{e_mail}]""")
    puts "SEUS DADOS ESTÃO CORRETOS [Sim - 1] [Não - 2]: "
    decisao_cliente = validar_entrada(2)
    next if decisao_cliente == 2
        
    File.open("banco_de_dados_clientes.txt", "a") do |arquivo|
      arquivo.puts("#{nome}|#{dia_nascimento}|#{mes_nascimento}|#{ano_nascimento}|#{estado}|#{cidade}|#{numero}|#{cep}|#{e_mail}|#{senha}|#{@desconto}")
    end

    puts "CADASTRO REALIZADO COM SUCESSO!"
    return [e_mail, senha]
   
  end
end 

# LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 
def carregar_dados_cliente(e_mail_cliente,senha_cliente)
  clientes = []
  File.open("banco_de_dados_clientes.txt") do |file|
    file.each do |line|
      if e_mail_cliente == line.chomp.split("|")[8] && senha_cliente == line.chomp.split("|")[9]
        clientes << Cliente.new(*line.chomp.split("|"))
      end
    end 
  end
  return clientes
end

# DEFINE A FORMA DE PAGAMENTO DA COMPRA E VÁLIDA A FORMA
def escolher_forma_de_pagamento(total)
  puts "PAGAMENTO"
  print"\nSELECIONE UMA FORMA DE PAGAMENTO [1 - CARTÃO DE DÉBITO] [2 - CARTÃO DE CRÉDITO] [3 - BOLETO]: "
  decisao_cliente = validar_entrada(3)

  if decisao_cliente == 1
    validar_dados_do_cartao
  elsif decisao_cliente == 2
    validar_dados_do_cartao 
    print "EM QUANTAS VEZES GOSTARIA DE PAGAR(ATÉ 6 VEZES): "
    parcelamento = validar_entrada(6)
    puts format("VALOR DA PARCELA: R$%.2f", total/parcelamento.to_f)
  else 
  end 

    
end 

# RECEBE O NÚMERO DE OPÇÕES VÁLIDAS E SÓ RETURNA A FUNÇÃO QUANDO A ENTRADA DO USUÁRIO É VÁLIDA
def validar_entrada (numero_de_opcoes_validas) 
  opções = (1..numero_de_opcoes_validas).to_a
  escolha_usuario = gets.chomp.strip.to_i
  while true do   
    if opções.include? escolha_usuario
        return escolha_usuario

    else
      puts "\nOPÇÃO INVÁLIDA"
      print "ESCOLHA ENTRE AS OPÇÕES VÁLIDAS #{opções}: "
      escolha_usuario = gets.chomp.strip.to_i
    end 
  end 
end 


# RECEBE O NÚMERO DE OPÇÕES VÁLIDAS E SÓ RETORNA A FUNÇÃO QUANDO A ENTRADA DO USUÁRIO É VÁLIDA E SE O LIVRO EXISTE NA LISTA DE LIVROS
def validar_id (lista_de_livros)
  escolha_usuario_id = gets.chomp.strip.to_i
  while true do
    for livro in lista_de_livros
      if livro.id == escolha_usuario_id
        return escolha_usuario_id
      end 
    end 
    puts "\nOPÇÃO INVÁLIDA -- LIVRO NÃO FAZ PARTE DA LISTA"
    print "\nINSIRA OUTRO ID : "
    escolha_usuario_id = gets.chomp.strip.to_i
  end 
end 



def validar_dados_do_cartao 
  ano_atual = Time.new.year % 2000
  mes_atual = Time.new.month 
  dia_atual = Time.new.day

  valido = false
    while not valido 
      print "NOME TITULAR DO CARTÃO: "
      nome_titular_cartao = gets.chomp.strip.upcase
      print "INFORME O NÚMERO DO CARTÃO: "
      numero_cartao_cliente = gets.chomp.strip
      print "MES DE VENCIMENTO DO CARTÃO (2 Dígitos): "
      mes_cartao_vencimento = gets.chomp.strip
      print "ANO DE VENCIMENTO DO CARTÃO (2 Dígitos): "
      ano_cartao_vencimento = gets.chomp.strip
      print "CÓDIGO DE SEGURANÇA (3 Dígitos): "
      codigo_seguranca_cartao = gets.chomp.strip

      if ano_atual < ano_cartao_vencimento.to_i
        valido = numero_cartao_cliente.size == 16 && mes_cartao_vencimento.size == 2 && ano_cartao_vencimento.size == 2 && codigo_seguranca_cartao.size == 3  
      else
        valido = numero_cartao_cliente.size == 16 && mes_cartao_vencimento.size == 2 && ano_cartao_vencimento.size == 2 && codigo_seguranca_cartao.size == 3 && mes_cartao_vencimento.to_i >= mes_atual && ano_cartao_vencimento.to_i >= ano_atual 
      end 

      if not valido 
        puts "DADOS DO CARTÃO INVÁLIDO!"
      else
        puts "CARTÃO APROVADO" 
      end
    end  

end 

